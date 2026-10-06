import 'dart:async';

import 'package:fino/core/sync/remote_document.dart';
import 'package:fino/core/sync/remote_failure.dart';
import 'package:fino/core/sync/remote_filter.dart';
import 'package:fino/core/sync/remote_gateway.dart';
import 'package:fino/core/sync/remote_snapshot.dart';
import 'package:fino/core/sync/remote_write.dart';

/// Un servidor de mentira para probar la sincronización sin red: guarda los
/// lotes que recibe y puede fallar de forma programada.
class FakeRemoteGateway implements RemoteGateway {
  final batches = <List<RemoteWrite>>[];

  /// Fallas a lanzar, una por llamada a [commit], en orden (`null` = éxito).
  final failures = <RemoteFailure?>[];

  @override
  Future<void> commit(List<RemoteWrite> writes) async {
    if (failures.isNotEmpty) {
      final failure = failures.removeAt(0);
      if (failure != null) throw failure;
    }
    batches.add(writes);
  }

  @override
  Future<RemoteDocument?> get(String path) async => null;

  @override
  Stream<RemoteSnapshot> watchCollection(
    String path, {
    List<RemoteFilter> where = const [],
  }) => const Stream.empty();

  @override
  Stream<RemoteSnapshot> watchGroup(
    String collectionId, {
    List<RemoteFilter> where = const [],
  }) => const Stream.empty();

  @override
  Stream<RemoteDocument?> watchDocument(String path) => const Stream.empty();
}
