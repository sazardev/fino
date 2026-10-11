/// Decide qué instantánea es la inicial: solo la primera **del servidor**.
///
/// Las de caché (`isFromCache`) se reenvían, pero nunca son la inicial, así no
/// purgan lo local: el SDK puede entregarlas como única instantánea de una
/// consulta cuando el documento ya estaba en su caché por otro listener.
class InitialSnapshotTracker {
  var _initialSeen = false;

  bool next({required bool isFromCache}) {
    if (_initialSeen || isFromCache) return false;
    _initialSeen = true;
    return true;
  }
}
