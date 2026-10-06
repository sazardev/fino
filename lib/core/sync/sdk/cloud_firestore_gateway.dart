import 'package:cloud_firestore/cloud_firestore.dart';

import '../../database/outbox_operation.dart';
import '../remote_change.dart';
import '../remote_change_kind.dart';
import '../remote_document.dart';
import '../remote_filter.dart';
import '../remote_filter_op.dart';
import '../remote_gateway.dart';
import '../remote_snapshot.dart';
import '../remote_write.dart';
import 'firestore_failure_mapper.dart';
import 'firestore_value_codec.dart';

/// [RemoteGateway] sobre el SDK de Firestore (Android y web).
///
/// Los lotes salen como transacciones de solo escritura: son atómicas igual
/// que un batch, pero **fallan** sin conexión en vez de quedarse en la cola
/// interna del SDK (el outbox de Drift es quien guarda lo pendiente).
class CloudFirestoreGateway implements RemoteGateway {
  const new(
    this._firestore, {
    this.commitTimeout = const Duration(seconds: 20),
  });

  final FirebaseFirestore _firestore;
  final Duration commitTimeout;

  @override
  Future<void> commit(List<RemoteWrite> writes) async {
    if (writes.isEmpty) return;
    try {
      await _firestore.runTransaction<void>(
        (transaction) async {
          for (final write in writes) {
            final ref = _firestore.doc(write.path);
            final data = FirestoreValueCodec.encodeFields(write.fields);
            switch (write.operation) {
              case OutboxOperation.create || OutboxOperation.set:
                transaction.set(ref, data);
              case OutboxOperation.update:
                transaction.update(ref, data);
              case OutboxOperation.delete:
                transaction.delete(ref);
            }
          }
        },
        timeout: commitTimeout,
        maxAttempts: 1,
      );
    } on Object catch (error) {
      throw FirestoreFailureMapper.map(error);
    }
  }

  @override
  Future<RemoteDocument?> get(String path) async {
    try {
      final snapshot = await _firestore.doc(path).get();
      return _document(snapshot);
    } on Object catch (error) {
      throw FirestoreFailureMapper.map(error);
    }
  }

  @override
  Stream<RemoteSnapshot> watchCollection(
    String path, {
    List<RemoteFilter> where = const [],
  }) => _watch(_filtered(_firestore.collection(path), where));

  @override
  Stream<RemoteSnapshot> watchGroup(
    String collectionId, {
    List<RemoteFilter> where = const [],
  }) => _watch(_filtered(_firestore.collectionGroup(collectionId), where));

  @override
  Stream<RemoteDocument?> watchDocument(String path) => _firestore
      .doc(path)
      .snapshots()
      .where((snapshot) => !snapshot.metadata.isFromCache)
      .map(_document)
      .handleError((Object error) => throw FirestoreFailureMapper.map(error));

  Query<Map<String, dynamic>> _filtered(
    Query<Map<String, dynamic>> query,
    List<RemoteFilter> where,
  ) {
    var result = query;
    for (final filter in where) {
      result = switch (filter.op) {
        RemoteFilterOp.equal => result.where(
          filter.field,
          isEqualTo: filter.value,
        ),
        RemoteFilterOp.arrayContains => result.where(
          filter.field,
          arrayContains: filter.value,
        ),
      };
    }
    return result;
  }

  /// Sin conexión el SDK puede entregar primero una instantánea vacía "de
  /// caché": tomarla por la inicial haría borrar todo lo local. Se espera a
  /// una que venga del servidor.
  Stream<RemoteSnapshot> _watch(Query<Map<String, dynamic>> query) {
    var first = true;
    return query
        .snapshots()
        .where((snapshot) => !snapshot.metadata.isFromCache)
        .map((snapshot) {
          final isInitial = first;
          first = false;
          return RemoteSnapshot([
            for (final change in snapshot.docChanges)
              RemoteChange(_kind(change.type), _document(change.doc)!),
          ], isInitial: isInitial);
        })
        .handleError((Object error) => throw FirestoreFailureMapper.map(error));
  }

  RemoteChangeKind _kind(DocumentChangeType type) => switch (type) {
    DocumentChangeType.added => RemoteChangeKind.added,
    DocumentChangeType.modified => RemoteChangeKind.modified,
    DocumentChangeType.removed => RemoteChangeKind.removed,
  };

  RemoteDocument? _document(DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.exists
      ? RemoteDocument(
          snapshot.reference.path,
          FirestoreValueCodec.decodeFields(snapshot.data()),
        )
      : null;
}
