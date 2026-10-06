/// Estado de una deuda (SPEC §6.1).
enum DebtStatus {
  /// Debe y aún no ha avisado de pago.
  pending,

  /// El deudor dijo que pagó; falta que el acreedor confirme.
  paymentReported,

  /// El acreedor confirmó que recibió el dinero.
  confirmed,

  /// Anulada (error, perdonada o pedido cancelado). Terminal.
  cancelled;

  /// Una deuda viva bloquea salir/expulsar/eliminar equipo (SPEC §4.2).
  bool get isLive => this == pending || this == paymentReported;

  /// Deudas que ocupan parte del total del pedido.
  bool get isActive => this != cancelled;
}
