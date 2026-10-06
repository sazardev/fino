import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
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

/// Cambia el monto de una deuda pendiente (SPEC §5.5).
///
/// También refleja un pago parcial hecho por fuera: se baja el monto.
class UpdateDebtAmount {
  const new(this._newId);

  final IdGenerator _newId;

  /// [siblings] son todas las deudas del pedido (incluida [debt]).
  OrderChangeSet call({
    required String actorId,
    required Order order,
    required Debt debt,
    required List<Debt> siblings,
    required Money newAmount,
    required DateTime now,
  }) {
    OrderGuards.requireCreditor(actorId, order.creditorId);
    if (debt.status != DebtStatus.pending) {
      throw const OrderFailure(OrderFailureReason.invalidTransition);
    }
    if (!newAmount.isPositive) {
      throw const OrderFailure(OrderFailureReason.amountNotPositive);
    }
    if (newAmount == debt.amount) return OrderChangeSet.empty;

    final others = Money.sum(
      siblings
          .where((other) => other.id != debt.id && other.status.isActive)
          .map((other) => other.amount),
    );
    if (others + newAmount > order.total) {
      throw const OrderFailure(OrderFailureReason.sumExceedsTotal);
    }

    return OrderChangeSet(
      debts: [debt.copyWith(amount: newAmount, updatedAt: now)],
      ledger: [
        LedgerRecorder(_newId).record(
          orderId: order.id,
          type: LedgerEventType.debtAmountChanged,
          actorId: actorId,
          at: now,
          debtId: debt.id,
          amountBefore: debt.amount,
          amountAfter: newAmount,
        ),
      ],
      notifications: [
        NotificationIntent(
          kind: NotificationKind.debtAmountChanged,
          recipientId: debt.debtorId,
          actorId: actorId,
          teamId: order.teamId,
          target: NotificationTarget.debt(debt.id),
          amount: newAmount,
          concept: order.concept,
        ),
      ],
    );
  }
}
