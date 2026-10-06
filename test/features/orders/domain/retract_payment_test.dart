import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/entities/payment.dart';
import 'package:fino/features/orders/domain/entities/payout_snapshot.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/use_cases/retract_payment.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  final payment = Payment(
    id: 'p1',
    teamId: 't1',
    creditorId: 'omar',
    debtorId: 'ana',
    debtIds: const ['d1', 'd2'],
    payoutShown: const PayoutSnapshot(last4: '1234'),
    reportedAt: t0,
  );
  final cafe = buildOrder();
  final reported1 = buildDebt(
    status: DebtStatus.paymentReported,
    paymentId: 'p1',
  );
  final reported2 = buildDebt(
    id: 'd2',
    status: DebtStatus.paymentReported,
    paymentId: 'p1',
  );

  OrderChangeSet Function() retract({
    String actor = 'ana',
    List<Debt>? debts,
  }) =>
      () => RetractPayment(sequentialIds())(
        actorId: actor,
        payment: payment,
        debts: debts ?? [reported1, reported2],
        orders: {cafe.id: cafe},
        now: t0,
      );

  test('retracts the whole payment: debts return to pending (G7)', () {
    final changes = retract()();

    expect(
      changes.debts.map((d) => d.status),
      everyElement(DebtStatus.pending),
    );
    expect(changes.debts.map((d) => d.paymentId), everyElement(isNull));
    expect(
      changes.ledger.map((e) => e.type),
      everyElement(LedgerEventType.paymentRetracted),
    );
    final notification = changes.notifications.single;
    expect(notification.kind, NotificationKind.paymentRetracted);
    expect(notification.recipientId, 'omar');
    expect(notification.amount, pesos(120));
    expect(notification.debtCount, 2);
  });

  test('retracts only some debts of the payment', () {
    final changes = retract(debts: [reported1])();

    expect(changes.debts.single.id, 'd1');
    expect(changes.notifications.single.debtCount, 1);
  });

  test('retracting what is already pending changes nothing', () {
    final changes = retract(
      debts: [reported1.copyWith(status: DebtStatus.pending, paymentId: null)],
    )();

    expect(changes.isEmpty, isTrue);
  });

  test('cannot retract once the creditor confirmed', () {
    expect(
      retract(debts: [reported1.copyWith(status: DebtStatus.confirmed)]),
      throwsOrder(OrderFailureReason.invalidTransition),
    );
  });

  test('cannot retract a debt that belongs to another payment', () {
    expect(
      retract(debts: [reported1.copyWith(paymentId: 'p9')]),
      throwsOrder(OrderFailureReason.invalidTransition),
    );
  });

  test('only the debtor retracts, and something must be selected', () {
    expect(retract(actor: 'omar'), throwsOrder(OrderFailureReason.notDebtor));
    expect(
      retract(debts: const []),
      throwsOrder(OrderFailureReason.emptySelection),
    );
  });
}
