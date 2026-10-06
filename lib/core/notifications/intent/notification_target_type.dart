/// A qué pantalla abre una notificación (SPEC N3), sin conocer rutas.
enum NotificationTargetType {
  /// Una deuda concreta.
  debt,

  /// Un pago (agrupador de deudas).
  payment,

  /// Pantalla *Pagar* hacia un acreedor (el id es el del acreedor).
  pay,

  /// Historial del equipo (el id es el del equipo).
  history,

  /// El equipo (el id es el del equipo).
  team,
}
