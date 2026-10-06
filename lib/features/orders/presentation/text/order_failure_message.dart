import '../../domain/failures/order_failure_reason.dart';

/// Qué decirle a la persona cuando una regla rechaza lo que intentó.
abstract final class OrderFailureMessage {
  static String of(OrderFailureReason reason) => switch (reason) {
    OrderFailureReason.notCreditor => 'Solo quien pagó el pedido puede hacerlo',
    OrderFailureReason.notDebtor => 'Solo quien debe puede hacerlo',
    OrderFailureReason.notTeamMember => 'Esa persona ya no está en el equipo',
    OrderFailureReason.creditorWithoutPayoutMethod =>
      'Primero configura tu cuenta de cobro en el equipo',
    OrderFailureReason.conceptRequired => 'Escribe qué fue (ej. Café)',
    OrderFailureReason.conceptTooLong => 'El concepto es demasiado largo',
    OrderFailureReason.referenceTooLong => 'La referencia es demasiado larga',
    OrderFailureReason.commentRequired => 'Escribe un comentario',
    OrderFailureReason.commentTooLong => 'El comentario es demasiado largo',
    OrderFailureReason.totalNotPositive => 'Escribe cuánto se gastó',
    OrderFailureReason.noDebtors => 'Elige quién te debe',
    OrderFailureReason.duplicateParticipant =>
      'Esa persona ya está en el pedido',
    OrderFailureReason.creditorCannotOwe => 'No puedes deberte a ti',
    OrderFailureReason.amountNotPositive => 'Cada monto debe ser mayor a cero',
    OrderFailureReason.fixedExceedsTotal =>
      'Los montos fijados pasan del total',
    OrderFailureReason.shareTooSmall => 'El total no alcanza para repartir',
    OrderFailureReason.sumExceedsTotal => 'Las deudas pasan del total',
    OrderFailureReason.totalBelowDebts =>
      'El total no puede ser menor que lo que ya se debe',
    OrderFailureReason.participantsMismatch =>
      'El pedido cambió; vuelve a intentarlo',
    OrderFailureReason.invalidTransition || OrderFailureReason.staleSelection =>
      'Esto cambió mientras tanto; revisa el estado actual',
    OrderFailureReason.debtHasReportedPayment =>
      'Hay un pago reportado: confírmalo o recházalo primero',
    OrderFailureReason.orderNotOpen => 'El pedido ya está cerrado',
    OrderFailureReason.orderHasPaymentActivity =>
      'Ya hay pagos: cancela las deudas pendientes una por una',
    OrderFailureReason.emptySelection => 'Elige al menos una deuda',
    OrderFailureReason.invalidPaymentSelection =>
      'Solo puedes pagar junto lo de una misma persona',
    OrderFailureReason.debtorLeftTeam =>
      'Esa persona salió del equipo; ya no se puede deshacer',
    OrderFailureReason.notFound => 'Ya no existe',
  };
}
