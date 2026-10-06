/// Mensajes rápidos del acreedor (SPEC A2). El texto lo pone la capa de UI.
enum NoticeTemplate {
  /// "¿Ya me pagaste?"
  askIfPaid,

  /// "Ya pagué, no me paguen aún."
  holdPayments,

  /// "Me falta confirmar tu pago."
  pendingConfirmation,
}
