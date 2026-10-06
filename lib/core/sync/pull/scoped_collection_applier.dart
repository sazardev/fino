import '../../database/app_database.dart';
import '../remote_change_kind.dart';
import '../remote_document.dart';
import '../remote_snapshot.dart';

/// Aplica a Drift lo que llega de una colección de Firestore.
///
/// Reglas de oro de la sincronización de bajada:
/// - Lo que tiene escrituras pendientes en el outbox **no se pisa**: lo local
///   es más nuevo que lo que el servidor aún sabe.
/// - En la instantánea inicial, lo local de este alcance que el servidor no
///   trae ya no existe (y no está pendiente): se borra.
abstract class ScopedCollectionApplier {
  const new(this.db);

  final AppDatabase db;

  /// Crea o actualiza la fila de [document].
  Future<void> upsert(RemoteDocument document);

  /// Borra la fila con ese id.
  Future<void> delete(String id);

  /// Ids locales de este alcance (para la purga de la instantánea inicial).
  Future<Set<String>> localIds();

  /// Ruta remota de un id local.
  String pathOf(String id);

  /// Las colecciones que se escuchan con varias consultas que se solapan no
  /// pueden purgar con cada una.
  bool get purgesOnInitial => true;

  Future<void> apply(RemoteSnapshot snapshot) => db.transaction(() async {
    final pending = await db.outboxDao.pendingPaths();
    final remoteIds = <String>{};
    for (final change in snapshot.changes) {
      final document = change.document;
      remoteIds.add(document.id);
      if (pending.contains(document.path)) continue;
      if (change.kind == RemoteChangeKind.removed) {
        await delete(document.id);
      } else {
        await upsert(document);
      }
    }
    if (!snapshot.isInitial || !purgesOnInitial) return;
    for (final id in await localIds()) {
      if (!remoteIds.contains(id) && !pending.contains(pathOf(id))) {
        await delete(id);
      }
    }
  });
}
