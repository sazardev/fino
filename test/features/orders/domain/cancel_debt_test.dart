import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/use_cases/cancel_debt.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  final order = buildOrder();

  OrderChangeSet Function() cancel({
    String actor = 'omar',
    DebtStatus status = DebtStatus.pending,
    String? note,
  }) =>
      () => CancelDebt(sequentialIds())(
        actorId: actor,
        debt: buildDebt(status: status),
        order: order,
        note: note,
        now: t0,
      );

  test('cancels a pending debt with a reason and tells the debtor', () {
    final changes = cancel(note: ' perdonada ')();

    expect(changes.debts.single.status, DebtStatus.cancelled);
    expect(changes.ledger.single.type, LedgerEventType.debtCancelled);
    expect(changes.ledger.single.note, 'perdonada');
    expect(changes.ledger.single.amountBefore, pesos(60));
    final notification = changes.notifications.single;
    expect(notification.kind, NotificationKind.debtCancelled);
    expect(notification.recipientId, 'ana');
    expect(notification.target, const NotificationTarget.history('t1'));
    expect(notification.note, 'perdonada');
  });

  test('cancelling twice is a no-op', () {
    expect(cancel(status: DebtStatus.cancelled)().isEmpty, isTrue);
  });

  test('cannot cancel a debt with a reported payment (D2)', () {
    expect(
      cancel(status: DebtStatus.paymentReported),
      throwsOrder(OrderFailureReason.debtHasReportedPayment),
    );
  });

  test('cannot cancel a confirmed debt', () {
    expect(
      cancel(status: DebtStatus.confirmed),
      throwsOrder(OrderFailureReason.invalidTransition),
    );
  });

  test('only the creditor cancels (D1)', () {
    expect(cancel(actor: 'ana'), throwsOrder(OrderFailureReason.notCreditor));
  });
}
