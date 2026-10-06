import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/entities/payout_snapshot.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/use_cases/report_payment.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  const shown = PayoutSnapshot(bankName: 'BBVA', last4: '1234');
  final cafe = buildOrder();
  final sandwich = buildOrder(id: 'o2', concept: 'Sándwich');
  final orders = {cafe.id: cafe, sandwich.id: sandwich};

  final coffeeDebt = buildDebt();
  final sandwichDebt = buildDebt(id: 'd2', orderId: 'o2', amount: pesos(85));

  OrderChangeSet Function() report({
    String actor = 'ana',
    List<Debt>? debts,
    Map<String, Money>? shownAmounts,
    String? reference,
  }) {
    final list = debts ?? [coffeeDebt, sandwichDebt];
    return () => ReportPayment(sequentialIds())(
      actorId: actor,
      debts: list,
      shownAmounts:
          shownAmounts ?? {for (final debt in list) debt.id: debt.amount},
      orders: orders,
      payoutShown: shown,
      now: t0,
      reference: reference,
    );
  }

  test('one payment covers several debts from different orders (G1, G3)', () {
    final changes = report(reference: ' SPEI-99 ')();
    final payment = changes.payments.single;

    expect(payment.debtIds, ['d1', 'd2']);
    expect(payment.debtorId, 'ana');
    expect(payment.creditorId, 'omar');
    expect(payment.reference, 'SPEI-99');
    expect(payment.payoutShown, shown);
    expect(
      changes.debts.map((d) => d.status),
      everyElement(DebtStatus.paymentReported),
    );
    expect(changes.debts.map((d) => d.paymentId), everyElement(payment.id));
    expect(
      changes.ledger.map((e) => e.type),
      everyElement(LedgerEventType.paymentReported),
    );
    expect(changes.ledger.first.note, 'SPEI-99');
  });

  test('the creditor gets a single summary notification (G4)', () {
    final notification = report()().notifications.single;

    expect(notification.kind, NotificationKind.paymentReported);
    expect(notification.recipientId, 'omar');
    expect(notification.actorId, 'ana');
    expect(notification.amount, pesos(145));
    expect(notification.debtCount, 2);
    expect(notification.concept, 'Café');
    expect(
      notification.target,
      NotificationTarget.payment(report()().payments.single.id),
    );
  });

  test('a blank reference is stored as none', () {
    expect(report(reference: '  ')().payments.single.reference, isNull);
  });

  test('rejects a reference that is too long', () {
    expect(
      report(reference: 'x' * 101),
      throwsOrder(OrderFailureReason.referenceTooLong),
    );
  });

  test('rejects an empty selection', () {
    expect(
      report(debts: const []),
      throwsOrder(OrderFailureReason.emptySelection),
    );
  });

  test('rejects paying a debt that is not yours', () {
    expect(report(actor: 'beto'), throwsOrder(OrderFailureReason.notDebtor));
  });

  test('rejects mixing creditors or teams (G1)', () {
    expect(
      report(
        debts: [
          coffeeDebt,
          sandwichDebt.copyWith(creditorId: 'luis'),
        ],
      ),
      throwsOrder(OrderFailureReason.invalidPaymentSelection),
    );
    expect(
      report(
        debts: [
          coffeeDebt,
          sandwichDebt.copyWith(teamId: 't2'),
        ],
      ),
      throwsOrder(OrderFailureReason.invalidPaymentSelection),
    );
  });

  test('aborts when a debt is no longer pending (G8)', () {
    expect(
      report(
        debts: [
          coffeeDebt,
          sandwichDebt.copyWith(status: DebtStatus.cancelled),
        ],
      ),
      throwsOrder(OrderFailureReason.staleSelection),
    );
  });

  test('aborts when an amount changed after it was shown (G8)', () {
    expect(
      report(shownAmounts: {'d1': pesos(50), 'd2': pesos(85)}),
      throwsOrder(OrderFailureReason.staleSelection),
    );
  });
}
