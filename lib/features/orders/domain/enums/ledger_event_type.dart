/// Eventos que deja la bitácora de un pedido (SPEC §11).
enum LedgerEventType {
  orderCreated(confidential: false),
  orderDetailsEdited(confidential: false),
  orderTotalChanged(confidential: false),
  orderRedistributed(confidential: false),
  orderCancelled(confidential: false),
  debtAdded(confidential: false),
  debtAmountChanged(confidential: false),
  debtCancelled(confidential: false),

  /// Su nota es la referencia de pago: solo acreedor y deudor la ven.
  paymentReported(confidential: true),
  paymentRetracted(confidential: false),
  paymentConfirmed(confidential: false),
  paymentRejected(confidential: false),
  confirmationUndone(confidential: false),

  /// Su nota es el comentario del deudor: solo acreedor y deudor lo ven.
  debtObjected(confidential: true);

  new({required this.confidential});

  final bool confidential;
}
