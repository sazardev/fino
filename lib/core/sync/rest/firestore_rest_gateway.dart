import 'dart:async';

import '../remote_document.dart';
import '../remote_failure.dart';
import '../remote_failure_kind.dart';
import '../remote_filter.dart';
import '../remote_gateway.dart';
import '../remote_snapshot.dart';
import '../remote_write.dart';
import 'rest_document_parser.dart';
import 'rest_failure_mapper.dart';
import 'rest_http.dart';
import 'rest_polling.dart';
import 'rest_query_builder.dart';
import 'rest_write_encoder.dart';

/// [RemoteGateway] sobre la API REST de Firestore.
///
/// Existe para donde el SDK no corre (Linux) y para probar contra el emulador
/// con las reglas reales. Como REST no tiene escucha en vivo, las consultas se
/// repiten cada [pollInterval] y se emite lo que cambió.
class FirestoreRestGateway implements RemoteGateway {
  new({
    required this._host,
    required this._project,
    required this._tokenProvider,
    this._request = ioRestRequest,
    this.pollInterval = const Duration(seconds: 1),
  });

  final String _host;
  final String _project;

  /// El token de la sesión actual (`null` = sin sesión).
  final String? Function() _tokenProvider;
  final RestRequest _request;
  final Duration pollInterval;

  String get _documents => 'projects/$_project/databases/(default)/documents';

  Uri _url(String path) => Uri.http(_host, '/v1/$path');

  @override
  Future<void> commit(List<RemoteWrite> writes) async {
    if (writes.isEmpty) return;
    await _send(
      'POST',
      _url('$_documents:commit'),
      body: {
        'writes': [
          for (final write in writes)
            RestWriteEncoder.encode(write, _documents),
        ],
      },
    );
  }

  @override
  Future<RemoteDocument?> get(String path) async {
    try {
      final json = await _send('GET', _url('$_documents/$path'));
      return RestDocumentParser.parse(json! as Map<String, Object?>);
    } on RemoteFailure catch (failure) {
      if (failure.kind == RemoteFailureKind.notFound) return null;
      rethrow;
    }
  }

  @override
  Stream<RemoteSnapshot> watchCollection(
    String path, {
    List<RemoteFilter> where = const [],
  }) {
    final cut = path.lastIndexOf('/');
    final parent = cut < 0
        ? _documents
        : '$_documents/${path.substring(0, cut)}';
    return RestPolling.collection(
      () => _runQuery(
        parent,
        collectionId: path.substring(cut + 1),
        allDescendants: false,
        where: where,
      ),
      pollInterval,
    );
  }

  @override
  Stream<RemoteSnapshot> watchGroup(
    String collectionId, {
    List<RemoteFilter> where = const [],
  }) => RestPolling.collection(
    () => _runQuery(
      _documents,
      collectionId: collectionId,
      allDescendants: true,
      where: where,
    ),
    pollInterval,
  );

  @override
  Stream<RemoteDocument?> watchDocument(String path) =>
      RestPolling.document(() => get(path), pollInterval);

  Future<List<RemoteDocument>> _runQuery(
    String parent, {
    required String collectionId,
    required bool allDescendants,
    required List<RemoteFilter> where,
  }) async {
    final json = await _send(
      'POST',
      _url('$parent:runQuery'),
      body: RestQueryBuilder.query(
        collectionId: collectionId,
        allDescendants: allDescendants,
        where: where,
      ),
    );
    return [
      for (final row in json! as List<Object?>)
        if ((row! as Map<String, Object?>)['document']
            case final Map<String, Object?> document)
          RestDocumentParser.parse(document),
    ];
  }

  Future<Object?> _send(
    String method,
    Uri url, {
    Map<String, Object?>? body,
  }) async {
    try {
      return await _request(
        method,
        url,
        body: body,
        bearerToken: _tokenProvider(),
      );
    } on Object catch (error) {
      throw RestFailureMapper.fromError(error);
    }
  }
}
