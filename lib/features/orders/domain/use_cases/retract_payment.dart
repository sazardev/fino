import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../entities/debt.dart';
import '../entities/order.dart';
import '../entities/order_change_set.dart';
import '../entities/payment.dart';
import '../enums/debt_status.dart';
import '../enums/ledger_event_type.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import 'debt_concepts.dart';
import 'ledger_recorder.dart';
import 'order_guards.dart';

/// El deudor retira su "Ya pagué", completo o solo algunas deudas (G7).
class RetractPayment {
  const new(this._newId);

  final IdGenerator _newId;

  /// Retirar algo que ya volvió a pendiente es un no-op.
  OrderChangeSet call({
    required String actorId,
    required Payment payment,
    required List<Debt> debts,
    required Map<String, Order> orders,
    required DateTime now,
  }) {
    if (debts.isEmpty) {
      throw const OrderFailure(OrderFailureReason.emptySelection);
    }
    OrderGuards.requireDebtor(actorId, payment.debtorId);
    final changed = <Debt>[];
    for (final debt in debts) {
      if (debt.status == DebtStatus.pending) continue;
      if (debt.status != DebtStatus.paymentReported ||
          debt.paymentId != payment.id) {
        throw const OrderFailure(OrderFailureReason.invalidTransition);
      }
      changed.add(
        debt.copyWith(
          status: DebtStatus.pending,
          paymentId: null,
          updatedAt: now,
        ),
      );
    }
    if (changed.isEmpty) return OrderChangeSet.empty;

    final recorder = LedgerRecorder(_newId);
    return OrderChangeSet(
      debts: changed,
      ledger: [
        for (final debt in changed)
          recorder.record(
            orderId: debt.orderId,
            type: LedgerEventType.paymentRetracted,
            actorId: actorId,
            at: now,
            debtId: debt.id,
            paymentId: payment.id,
          ),
      ],
      notifications: [
        NotificationIntent(
          kind: NotificationKind.paymentRetracted,
          recipientId: payment.creditorId,
          actorId: actorId,
          teamId: payment.teamId,
          target: NotificationTarget.payment(payment.id),
          amount: Money.sum(changed.map((debt) => debt.amount)),
          concept: DebtConcepts.lead(changed, orders),
          debtCount: changed.length,
        ),
      ],
    );
  }
}
