import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/use_cases/cancel_order.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  final order = buildOrder();

  OrderChangeSet Function() cancel(List<Debt> debts, {String actor = 'omar'}) =>
      () => CancelOrder(sequentialIds())(
        actorId: actor,
        order: order,
        debts: debts,
        note: ' me equivoqué ',
        now: t0,
      );

  test('cancels every pending debt atomically and tells each debtor', () {
    final changes = cancel([
      buildDebt(),
      buildDebt(id: 'd2', debtorId: 'beto'),
      buildDebt(id: 'd3', debtorId: 'cris', status: DebtStatus.cancelled),
    ])();

    expect(changes.debts, hasLength(2));
    expect(
      changes.debts.map((d) => d.status),
      everyElement(DebtStatus.cancelled),
    );
    expect(changes.ledger.last.type, LedgerEventType.orderCancelled);
    expect(changes.ledger.last.note, 'me equivoqué');
    expect(changes.notifications.map((n) => n.recipientId), ['ana', 'beto']);
    expect(
      changes.notifications.map((n) => n.kind),
      everyElement(NotificationKind.orderCancelled),
    );
  });

  test('blocked once a payment was reported or confirmed (SPEC 6.6)', () {
    for (final status in [DebtStatus.paymentReported, DebtStatus.confirmed]) {
      expect(
        cancel([buildDebt(), buildDebt(id: 'd2', status: status)]),
        throwsOrder(OrderFailureReason.orderHasPaymentActivity),
      );
    }
  });

  test('cancelling an already cancelled order is a no-op', () {
    expect(cancel([buildDebt(status: DebtStatus.cancelled)])().isEmpty, isTrue);
  });

  test('only the creditor cancels the order', () {
    expect(
      cancel([buildDebt()], actor: 'ana'),
      throwsOrder(OrderFailureReason.notCreditor),
    );
  });
}
