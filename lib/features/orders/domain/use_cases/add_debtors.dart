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
import '../enums/order_status.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import 'ledger_recorder.dart';
import 'order_guards.dart';

/// Agrega deudores a un pedido abierto (SPEC §5.5).
class AddDebtors {
  const new(this._newId);

  final IdGenerator _newId;

  /// [newDebtors] mapea cada nuevo deudor a su monto. Quien ya tiene una
  /// deuda activa en el pedido no se puede repetir (P6); quien tuvo una
  /// cancelada sí puede volver.
  OrderChangeSet call({
    required String actorId,
    required Order order,
    required List<Debt> debts,
    required Set<String> memberIds,
    required Map<String, Money> newDebtors,
    required DateTime now,
  }) {
    OrderGuards.requireCreditor(actorId, order.creditorId);
    if (newDebtors.isEmpty) {
      throw const OrderFailure(OrderFailureReason.noDebtors);
    }
    final status = OrderStatus.fromDebts(debts.map((debt) => debt.status));
    if (status != OrderStatus.open) {
      throw const OrderFailure(OrderFailureReason.orderNotOpen);
    }
    final active = debts.where((debt) => debt.status.isActive).toList();
    _validate(order, active, memberIds, newDebtors);

    final added = [
      for (final MapEntry(key: debtorId, value: amount) in newDebtors.entries)
        Debt(
          id: _newId(),
          orderId: order.id,
          teamId: order.teamId,
          creditorId: order.creditorId,
          debtorId: debtorId,
          amount: amount,
          status: DebtStatus.pending,
          createdAt: now,
          updatedAt: now,
        ),
    ];
    final recorder = LedgerRecorder(_newId);
    return OrderChangeSet(
      debts: added,
      ledger: [
        for (final debt in added)
          recorder.record(
            orderId: order.id,
            type: LedgerEventType.debtAdded,
            actorId: actorId,
            at: now,
            debtId: debt.id,
            amountAfter: debt.amount,
          ),
      ],
      notifications: [
        for (final debt in added)
          NotificationIntent(
            kind: NotificationKind.debtAddedToOrder,
            recipientId: debt.debtorId,
            actorId: actorId,
            teamId: order.teamId,
            target: NotificationTarget.debt(debt.id),
            amount: debt.amount,
            concept: order.concept,
          ),
      ],
    );
  }

  void _validate(
    Order order,
    List<Debt> active,
    Set<String> memberIds,
    Map<String, Money> newDebtors,
  ) {
    for (final debtorId in newDebtors.keys) {
      if (debtorId == order.creditorId) {
        throw const OrderFailure(OrderFailureReason.creditorCannotOwe);
      }
      if (!memberIds.contains(debtorId)) {
        throw const OrderFailure(OrderFailureReason.notTeamMember);
      }
      if (active.any((debt) => debt.debtorId == debtorId)) {
        throw const OrderFailure(OrderFailureReason.duplicateParticipant);
      }
    }
    if (newDebtors.values.any((amount) => !amount.isPositive)) {
      throw const OrderFailure(OrderFailureReason.amountNotPositive);
    }
    final committed = Money.sum(active.map((debt) => debt.amount));
    if (committed + Money.sum(newDebtors.values) > order.total) {
      throw const OrderFailure(OrderFailureReason.sumExceedsTotal);
    }
  }
}
