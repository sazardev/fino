import '../../../../core/format/money_format.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/notice_template_text.dart';

/// Lo que dice una notificación (SPEC §9), con quien la causó ya nombrado.
abstract final class NotificationText {
  static String of(NotificationIntent n, {required String actor}) {
    final amount = n.amount == null ? '' : MoneyFormat.format(n.amount!);
    final concept = n.concept ?? 'un pedido';
    final note = n.note == null ? '' : ': «${n.note}»';
    return switch (n.kind) {
      NotificationKind.orderDebtCreated =>
        '$actor registró $concept: debes $amount',
      NotificationKind.debtAddedToOrder =>
        '$actor te agregó a $concept: debes $amount',
      NotificationKind.debtAmountChanged =>
        '$actor ajustó $concept: ahora debes $amount',
      NotificationKind.paymentReported =>
        (n.debtCount ?? 1) > 1
            ? '$actor pagó ${n.debtCount} deudas · $amount'
            : '$actor dice que ya te pagó $amount de $concept',
      NotificationKind.paymentRetracted =>
        '$actor retiró su aviso de pago de $concept',
      NotificationKind.paymentReviewed => _reviewed(n, actor, amount, note),
      NotificationKind.confirmationUndone =>
        '$actor deshizo la confirmación de $concept: vuelve a estar por '
            'confirmar',
      NotificationKind.debtCancelled => '$actor canceló tu deuda de $concept',
      NotificationKind.orderCancelled => '$actor canceló el pedido $concept',
      NotificationKind.notice => _notice(n, actor, amount),
      NotificationKind.debtObjected => '$actor objetó $concept$note',
      NotificationKind.paymentAwaitingConfirmation =>
        '$actor reportó un pago de $amount hace más de 2 días sin confirmar',
      NotificationKind.memberJoined => '$actor se unió al equipo',
    };
  }

  static String _reviewed(
    NotificationIntent n,
    String actor,
    String amount,
    String note,
  ) {
    final confirmed = n.debtCount ?? 0;
    final rejected = n.rejectedCount ?? 0;
    if (rejected == 0) return '$actor confirmó tu pago de $amount. ¡Listo!';
    if (confirmed == 0) {
      return '$actor no recibió tu pago de ${n.concept ?? 'un pedido'}$note';
    }
    return '$actor confirmó $confirmed y rechazó $rejected de tu pago$note';
  }

  static String _notice(NotificationIntent n, String actor, String amount) {
    final message = n.note ?? NoticeTemplateText.of(n.templateKey ?? '');
    final owed = amount.isEmpty ? '' : ' · Le debes $amount';
    return '$actor: «$message»$owed';
  }
}
