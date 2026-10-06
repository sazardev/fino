import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../entities/debt.dart';
import '../entities/ledger_entry.dart';
import '../entities/order.dart';
import '../entities/order_change_set.dart';
import '../enums/debt_status.dart';
import '../enums/ledger_event_type.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import '../split/split_calculator.dart';
import '../split/split_entry.dart';
import 'ledger_recorder.dart';
import 'order_guards.dart';

/// "Re-repartir": vuelve a repartir solo entre las deudas pendientes
/// (SPEC §5.5). Las reportadas y confirmadas cuentan como fijas y no se
/// tocan.
class RedistributePending {
  const new(this._newId, [this._calculator = const SplitCalculator()]);

  final IdGenerator _newId;
  final SplitCalculator _calculator;

  /// [entries] debe nombrar exactamente a los deudores con deuda pendiente.
  OrderChangeSet call({
    required String actorId,
    required Order order,
    required List<Debt> debts,
    required bool creditorIncluded,
    required List<SplitEntry> entries,
    required DateTime now,
  }) {
    OrderGuards.requireCreditor(actorId, order.creditorId);
    final pending = debts
        .where((debt) => debt.status == DebtStatus.pending)
        .toList();
    final pendingIds = pending.map((debt) => debt.debtorId).toSet();
    if (pendingIds.length != entries.length ||
        !entries.every((entry) => pendingIds.contains(entry.userId))) {
      throw const OrderFailure(OrderFailureReason.participantsMismatch);
    }

    final frozen = Money.sum(
      debts
          .where((d) => d.status.isActive && d.status != DebtStatus.pending)
          .map((debt) => debt.amount),
    );
    final split = _calculator.calculate(
      total: order.total - frozen,
      creditorId: order.creditorId,
      creditorIncluded: creditorIncluded,
      entries: entries,
    );

    final changed = [
      for (final debt in pending)
        if (split.amountByDebtor[debt.debtorId] != debt.amount)
          debt.copyWith(
            amount: split.amountByDebtor[debt.debtorId]!,
            updatedAt: now,
          ),
    ];
    if (changed.isEmpty) return OrderChangeSet.empty;
    return _changeSet(actorId, order, pending, changed, now);
  }

  OrderChangeSet _changeSet(
    String actorId,
    Order order,
    List<Debt> before,
    List<Debt> changed,
    DateTime now,
  ) {
    final recorder = LedgerRecorder(_newId);
    final previous = {for (final debt in before) debt.id: debt.amount};
    final ledger = <LedgerEntry>[
      recorder.record(
        orderId: order.id,
        type: LedgerEventType.orderRedistributed,
        actorId: actorId,
        at: now,
      ),
      for (final debt in changed)
        recorder.record(
          orderId: order.id,
          type: LedgerEventType.debtAmountChanged,
          actorId: actorId,
          at: now,
          debtId: debt.id,
          amountBefore: previous[debt.id],
          amountAfter: debt.amount,
        ),
    ];
    return OrderChangeSet(
      debts: changed,
      ledger: ledger,
      notifications: [
        for (final debt in changed)
          NotificationIntent(
            kind: NotificationKind.debtAmountChanged,
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
}
