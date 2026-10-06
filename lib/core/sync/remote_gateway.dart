import 'remote_document.dart';
import 'remote_filter.dart';
import 'remote_snapshot.dart';
import 'remote_write.dart';

/// La única puerta hacia Firestore. Hay una implementación con el SDK
/// (Android, web) y otra por REST (Linux y pruebas contra el emulador).
///
/// Todos los errores salen como `RemoteFailure`.
abstract interface class RemoteGateway {
  /// Aplica [writes] en UN solo lote atómico (todo o nada).
  Future<void> commit(List<RemoteWrite> writes);

  /// El documento en [path], o `null` si no existe.
  Future<RemoteDocument?> get(String path);

  /// Escucha una colección; emite la instantánea inicial y después cambios.
  Stream<RemoteSnapshot> watchCollection(
    String path, {
    List<RemoteFilter> where = const [],
  });

  /// Escucha todas las colecciones llamadas [collectionId], a cualquier
  /// profundidad.
  Stream<RemoteSnapshot> watchGroup(
    String collectionId, {
    List<RemoteFilter> where = const [],
  });

  /// Escucha un documento; emite `null` si no existe o desaparece.
  Stream<RemoteDocument?> watchDocument(String path);
}
