import '../remote_document.dart';
import '../remote_snapshot.dart';
import 'snapshot_differ.dart';

/// REST no tiene escucha en vivo: se repite la consulta y se emite lo que
/// cambió.
abstract final class RestPolling {
  /// Una colección: la instantánea inicial y después solo los cambios.
  static Stream<RemoteSnapshot> collection(
    Future<List<RemoteDocument>> Function() fetch,
    Duration interval,
  ) async* {
    final differ = SnapshotDiffer();
    while (true) {
      final snapshot = differ.next(await fetch());
      if (snapshot != null) yield snapshot;
      await Future<void>.delayed(interval);
    }
  }

  /// Un documento: su valor ahora y cada vez que cambia (`null` si no existe).
  static Stream<RemoteDocument?> document(
    Future<RemoteDocument?> Function() fetch,
    Duration interval,
  ) async* {
    RemoteDocument? last;
    var first = true;
    while (true) {
      final current = await fetch();
      if (first || current != last) yield current;
      first = false;
      last = current;
      await Future<void>.delayed(interval);
    }
  }
}
