import '../../../../core/ids/id_generator.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../entities/debt.dart';
import '../entities/order.dart';
import '../entities/order_change_set.dart';
import '../enums/debt_status.dart';
import '../enums/ledger_event_type.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import 'ledger_recorder.dart';
import 'order_guards.dart';
import 'order_text.dart';

/// El acreedor cancela (o perdona) una deuda pendiente (SPEC §6.5).
class CancelDebt {
  const new(this._newId);

  final IdGenerator _newId;

  /// No se puede cancelar una deuda con pago reportado (D2): primero se
  /// confirma o se rechaza. Cancelar una ya cancelada es un no-op.
  OrderChangeSet call({
    required String actorId,
    required Debt debt,
    required Order order,
    required DateTime now,
    String? note,
  }) {
    OrderGuards.requireCreditor(actorId, debt.creditorId);
    if (debt.status == DebtStatus.cancelled) return OrderChangeSet.empty;
    if (debt.status == DebtStatus.paymentReported) {
      throw const OrderFailure(OrderFailureReason.debtHasReportedPayment);
    }
    if (debt.status != DebtStatus.pending) {
      throw const OrderFailure(OrderFailureReason.invalidTransition);
    }

    final reason = OrderText.reason(note);
    return OrderChangeSet(
      debts: [debt.copyWith(status: DebtStatus.cancelled, updatedAt: now)],
      ledger: [
        LedgerRecorder(_newId).record(
          orderId: debt.orderId,
          type: LedgerEventType.debtCancelled,
          actorId: actorId,
          at: now,
          debtId: debt.id,
          amountBefore: debt.amount,
          note: reason,
        ),
      ],
      notifications: [
        NotificationIntent(
          kind: NotificationKind.debtCancelled,
          recipientId: debt.debtorId,
          actorId: actorId,
          teamId: debt.teamId,
          target: NotificationTarget.history(debt.teamId),
          amount: debt.amount,
          concept: order.concept,
          note: reason,
        ),
      ],
    );
  }
}
