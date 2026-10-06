/// Por qué falló una llamada al servidor.
enum RemoteFailureKind {
  /// Las reglas rechazaron la operación: reintentar no cambia nada.
  permissionDenied,

  /// El documento que se quería actualizar no existe.
  notFound,

  /// El documento que se quería crear ya existe.
  alreadyExists,

  /// No hay sesión válida.
  unauthenticated,

  /// Sin red o servidor no disponible: se reintenta más tarde.
  unavailable,

  /// Cualquier otro error.
  other,
}
