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
import '../split/split_calculator.dart';
import '../split/split_entry.dart';
import 'ledger_recorder.dart';
import 'order_text.dart';

/// Registra un pedido y sus deudas (SPEC §5.1–5.2).
class CreateOrder {
  const new(this._newId, [this._calculator = const SplitCalculator()]);

  final IdGenerator _newId;
  final SplitCalculator _calculator;

  OrderChangeSet call({
    required String creditorId,
    required String teamId,
    required Set<String> memberIds,
    required bool creditorHasPayoutMethod,
    required String concept,
    required Money total,
    required DateTime spentAt,
    required bool creditorIncluded,
    required List<SplitEntry> entries,
    required DateTime now,
    String? note,
  }) {
    if (!memberIds.contains(creditorId) ||
        !entries.every((entry) => memberIds.contains(entry.userId))) {
      throw const OrderFailure(OrderFailureReason.notTeamMember);
    }
    if (!creditorHasPayoutMethod) {
      throw const OrderFailure(OrderFailureReason.creditorWithoutPayoutMethod);
    }
    final cleanConcept = OrderText.concept(concept);
    final split = _calculator.calculate(
      total: total,
      creditorId: creditorId,
      creditorIncluded: creditorIncluded,
      entries: entries,
    );

    final order = Order(
      id: _newId(),
      teamId: teamId,
      creditorId: creditorId,
      concept: cleanConcept,
      note: OrderText.note(note),
      total: total,
      spentAt: spentAt,
      createdAt: now,
      updatedAt: now,
    );
    final debts = [
      for (final MapEntry(key: debtorId, value: amount)
          in split.amountByDebtor.entries)
        Debt(
          id: _newId(),
          orderId: order.id,
          teamId: teamId,
          creditorId: creditorId,
          debtorId: debtorId,
          amount: amount,
          status: DebtStatus.pending,
          createdAt: now,
          updatedAt: now,
        ),
    ];

    final recorder = LedgerRecorder(_newId);
    return OrderChangeSet(
      order: order,
      debts: debts,
      ledger: [
        recorder.record(
          orderId: order.id,
          type: LedgerEventType.orderCreated,
          actorId: creditorId,
          at: now,
          amountAfter: total,
        ),
        for (final debt in debts)
          recorder.record(
            orderId: order.id,
            type: LedgerEventType.debtAdded,
            actorId: creditorId,
            at: now,
            debtId: debt.id,
            amountAfter: debt.amount,
          ),
      ],
      notifications: [
        for (final debt in debts)
          NotificationIntent(
            kind: NotificationKind.orderDebtCreated,
            recipientId: debt.debtorId,
            actorId: creditorId,
            teamId: teamId,
            target: NotificationTarget.debt(debt.id),
            amount: debt.amount,
            concept: order.concept,
          ),
      ],
    );
  }
}
