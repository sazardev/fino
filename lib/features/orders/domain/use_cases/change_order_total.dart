import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../entities/debt.dart';
import '../entities/order.dart';
import '../entities/order_change_set.dart';
import '../enums/ledger_event_type.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import 'ledger_recorder.dart';
import 'order_guards.dart';

/// Cambia el monto total del pedido (SPEC §5.5).
class ChangeOrderTotal {
  const new(this._newId);

  final IdGenerator _newId;

  /// El nuevo total debe seguir cubriendo la suma de las deudas activas.
  OrderChangeSet call({
    required String actorId,
    required Order order,
    required List<Debt> debts,
    required Money newTotal,
    required DateTime now,
  }) {
    OrderGuards.requireCreditor(actorId, order.creditorId);
    if (!newTotal.isPositive) {
      throw const OrderFailure(OrderFailureReason.totalNotPositive);
    }
    final committed = Money.sum(
      debts.where((debt) => debt.status.isActive).map((debt) => debt.amount),
    );
    if (newTotal < committed) {
      throw const OrderFailure(OrderFailureReason.totalBelowDebts);
    }
    if (newTotal == order.total) return OrderChangeSet.empty;

    return OrderChangeSet(
      order: order.copyWith(total: newTotal, updatedAt: now),
      ledger: [
        LedgerRecorder(_newId).record(
          orderId: order.id,
          type: LedgerEventType.orderTotalChanged,
          actorId: actorId,
          at: now,
          amountBefore: order.total,
          amountAfter: newTotal,
        ),
      ],
    );
  }
}
