/// Valores que no se pueden calcular en el dispositivo: los resuelve el
/// servidor al aplicar la escritura.
enum RemoteMarker {
  /// La hora del servidor (`request.time`): reglas y LWW dependen de ella.
  serverTimestamp,

  /// Quita el campo del documento (solo en `update`).
  fieldDelete,
}
