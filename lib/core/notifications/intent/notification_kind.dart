/// Cada evento de negocio que debe avisarle a alguien (SPEC §9).
enum NotificationKind {
  /// #1 Pedido creado con una deuda para ti.
  orderDebtCreated,

  /// #2 Te agregaron a un pedido existente.
  debtAddedToOrder,

  /// #3 Cambió el monto de tu deuda (edición o re-reparto).
  debtAmountChanged,

  /// #4 Un deudor reportó un pago (una o varias deudas).
  paymentReported,

  /// #5 Un deudor retiró su pago (total o parcial).
  paymentRetracted,

  /// #6/#7 El acreedor confirmó y/o rechazó (un solo resumen por deudor).
  paymentReviewed,

  /// #8 El acreedor deshizo una confirmación.
  confirmationUndone,

  /// #9 El acreedor canceló tu deuda.
  debtCancelled,

  /// #10 El acreedor canceló el pedido completo.
  orderCancelled,

  /// #11 Aviso (recordatorio o texto libre) del acreedor.
  notice,

  /// #12 Un deudor objetó su deuda.
  debtObjected,

  /// #13 Un pago reportado lleva demasiado tiempo sin confirmar.
  paymentAwaitingConfirmation,

  /// #14 Alguien se unió al equipo.
  memberJoined,
}
