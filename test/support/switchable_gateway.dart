import 'package:fino/core/sync/remote_document.dart';
import 'package:fino/core/sync/remote_failure.dart';
import 'package:fino/core/sync/remote_failure_kind.dart';
import 'package:fino/core/sync/remote_filter.dart';
import 'package:fino/core/sync/remote_gateway.dart';
import 'package:fino/core/sync/remote_snapshot.dart';
import 'package:fino/core/sync/remote_write.dart';

/// Envuelve un gateway y simula perder la conexión: mientras [online] es
/// `false`, todo falla como "sin red".
class SwitchableGateway implements RemoteGateway {
  new(this._inner);

  final RemoteGateway _inner;
  bool online = true;

  void _check() {
    if (!online) {
      throw const RemoteFailure(RemoteFailureKind.unavailable, 'offline');
    }
  }

  @override
  Future<void> commit(List<RemoteWrite> writes) async {
    _check();
    await _inner.commit(writes);
  }

  @override
  Future<RemoteDocument?> get(String path) {
    _check();
    return _inner.get(path);
  }

  @override
  Stream<RemoteSnapshot> watchCollection(
    String path, {
    List<RemoteFilter> where = const [],
  }) => _guard(() => _inner.watchCollection(path, where: where));

  @override
  Stream<RemoteSnapshot> watchGroup(
    String collectionId, {
    List<RemoteFilter> where = const [],
  }) => _guard(() => _inner.watchGroup(collectionId, where: where));

  @override
  Stream<RemoteDocument?> watchDocument(String path) =>
      _guard(() => _inner.watchDocument(path));

  Stream<T> _guard<T>(Stream<T> Function() open) async* {
    _check();
    await for (final value in open()) {
      _check();
      yield value;
    }
  }
}
