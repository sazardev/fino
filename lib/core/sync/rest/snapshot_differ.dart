import '../remote_change.dart';
import '../remote_change_kind.dart';
import '../remote_document.dart';
import '../remote_snapshot.dart';

/// Compara lo que había con lo que hay ahora y dice qué cambió. Sirve a los
/// gateways que consultan en vez de recibir cambios del servidor.
class SnapshotDiffer {
  Map<String, RemoteDocument>? _previous;

  /// `null` si no hubo cambios (salvo la primera vez, que siempre emite).
  RemoteSnapshot? next(Iterable<RemoteDocument> current) {
    final now = {for (final doc in current) doc.path: doc};
    final before = _previous;
    _previous = now;
    if (before == null) {
      return RemoteSnapshot([
        for (final doc in now.values) RemoteChange(RemoteChangeKind.added, doc),
      ], isInitial: true);
    }
    final changes = [
      for (final doc in now.values)
        if (!before.containsKey(doc.path))
          RemoteChange(RemoteChangeKind.added, doc)
        else if (before[doc.path] != doc)
          RemoteChange(RemoteChangeKind.modified, doc),
      for (final doc in before.values)
        if (!now.containsKey(doc.path))
          RemoteChange(RemoteChangeKind.removed, doc),
    ];
    return changes.isEmpty ? null : RemoteSnapshot(changes, isInitial: false);
  }
}
