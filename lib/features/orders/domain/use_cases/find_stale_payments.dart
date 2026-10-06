import '../../../../core/money/money.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../entities/debt.dart';
import '../entities/order_change_set.dart';
import '../entities/payment.dart';
import '../enums/debt_status.dart';

/// Detecta pagos reportados que llevan demasiado sin confirmar y le avisa
/// al acreedor, una sola vez por pago (SPEC #13).
class FindStalePayments {
  const new({this.threshold = const Duration(hours: 48)});

  final Duration threshold;

  OrderChangeSet call({
    required List<Payment> payments,
    required List<Debt> debts,
    required DateTime now,
  }) {
    final flagged = <Payment>[];
    final notifications = <NotificationIntent>[];
    for (final payment in payments) {
      if (payment.awaitingConfirmationReminderSent) continue;
      if (now.difference(payment.reportedAt) < threshold) continue;
      final waiting = debts
          .where(
            (debt) =>
                debt.paymentId == payment.id &&
                debt.status == DebtStatus.paymentReported,
          )
          .toList();
      if (waiting.isEmpty) continue;

      flagged.add(payment.copyWith(awaitingConfirmationReminderSent: true));
      notifications.add(
        NotificationIntent(
          kind: NotificationKind.paymentAwaitingConfirmation,
          recipientId: payment.creditorId,
          actorId: payment.debtorId,
          teamId: payment.teamId,
          target: NotificationTarget.payment(payment.id),
          amount: Money.sum(waiting.map((debt) => debt.amount)),
          debtCount: waiting.length,
        ),
      );
    }
    return OrderChangeSet(payments: flagged, notifications: notifications);
  }
}
