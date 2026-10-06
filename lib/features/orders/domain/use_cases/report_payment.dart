import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../entities/debt.dart';
import '../entities/order.dart';
import '../entities/order_change_set.dart';
import '../entities/payment.dart';
import '../entities/payout_snapshot.dart';
import '../enums/debt_status.dart';
import '../enums/ledger_event_type.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import 'debt_concepts.dart';
import 'ledger_recorder.dart';
import 'order_guards.dart';
import 'order_text.dart';

/// "Ya pagué": el deudor reporta una o varias deudas de golpe (SPEC §6.3).
class ReportPayment {
  const new(this._newId);

  final IdGenerator _newId;

  /// [shownAmounts] son los montos que el deudor vio al pagar: si alguno
  /// cambió o la deuda ya no está pendiente, se aborta todo (G8).
  OrderChangeSet call({
    required String actorId,
    required List<Debt> debts,
    required Map<String, Money> shownAmounts,
    required Map<String, Order> orders,
    required PayoutSnapshot payoutShown,
    required DateTime now,
    String? reference,
  }) {
    if (debts.isEmpty) {
      throw const OrderFailure(OrderFailureReason.emptySelection);
    }
    final first = debts.first;
    for (final debt in debts) {
      OrderGuards.requireDebtor(actorId, debt.debtorId);
      if (debt.creditorId != first.creditorId || debt.teamId != first.teamId) {
        throw const OrderFailure(OrderFailureReason.invalidPaymentSelection);
      }
      if (debt.status != DebtStatus.pending ||
          shownAmounts[debt.id] != debt.amount) {
        throw const OrderFailure(OrderFailureReason.staleSelection);
      }
    }

    final cleanReference = OrderText.reference(reference);
    final payment = Payment(
      id: _newId(),
      teamId: first.teamId,
      creditorId: first.creditorId,
      debtorId: actorId,
      debtIds: [for (final debt in debts) debt.id],
      payoutShown: payoutShown,
      reportedAt: now,
      reference: cleanReference,
    );
    final reported = [
      for (final debt in debts)
        debt.copyWith(
          status: DebtStatus.paymentReported,
          paymentId: payment.id,
          updatedAt: now,
        ),
    ];

    final recorder = LedgerRecorder(_newId);
    return OrderChangeSet(
      debts: reported,
      payments: [payment],
      ledger: [
        for (final debt in reported)
          recorder.record(
            orderId: debt.orderId,
            type: LedgerEventType.paymentReported,
            actorId: actorId,
            at: now,
            debtId: debt.id,
            paymentId: payment.id,
            amountAfter: debt.amount,
            note: cleanReference,
          ),
      ],
      notifications: [
        NotificationIntent(
          kind: NotificationKind.paymentReported,
          recipientId: first.creditorId,
          actorId: actorId,
          teamId: first.teamId,
          target: NotificationTarget.payment(payment.id),
          amount: Money.sum(reported.map((debt) => debt.amount)),
          concept: DebtConcepts.lead(reported, orders),
          debtCount: reported.length,
        ),
      ],
    );
  }
}
