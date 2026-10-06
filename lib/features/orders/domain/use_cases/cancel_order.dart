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

/// El acreedor cancela el pedido completo (SPEC §6.6).
class CancelOrder {
  const new(this._newId);

  final IdGenerator _newId;

  /// Solo si ninguna deuda tiene pago reportado ni confirmado; si ya hubo
  /// movimiento se cancelan una por una las que sobren (`CancelDebt`).
  OrderChangeSet call({
    required String actorId,
    required Order order,
    required List<Debt> debts,
    required DateTime now,
    String? note,
  }) {
    OrderGuards.requireCreditor(actorId, order.creditorId);
    final hasActivity = debts.any(
      (debt) =>
          debt.status == DebtStatus.paymentReported ||
          debt.status == DebtStatus.confirmed,
    );
    if (hasActivity) {
      throw const OrderFailure(OrderFailureReason.orderHasPaymentActivity);
    }
    final pending = debts
        .where((debt) => debt.status == DebtStatus.pending)
        .toList();
    if (pending.isEmpty) return OrderChangeSet.empty;

    final reason = OrderText.reason(note);
    final recorder = LedgerRecorder(_newId);
    return OrderChangeSet(
      debts: [
        for (final debt in pending)
          debt.copyWith(status: DebtStatus.cancelled, updatedAt: now),
      ],
      ledger: [
        for (final debt in pending)
          recorder.record(
            orderId: order.id,
            type: LedgerEventType.debtCancelled,
            actorId: actorId,
            at: now,
            debtId: debt.id,
            amountBefore: debt.amount,
          ),
        recorder.record(
          orderId: order.id,
          type: LedgerEventType.orderCancelled,
          actorId: actorId,
          at: now,
          note: reason,
        ),
      ],
      notifications: [
        for (final debt in pending)
          NotificationIntent(
            kind: NotificationKind.orderCancelled,
            recipientId: debt.debtorId,
            actorId: actorId,
            teamId: order.teamId,
            target: NotificationTarget.history(order.teamId),
            concept: order.concept,
            note: reason,
          ),
      ],
    );
  }
}
