import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/use_cases/object_debt.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  OrderChangeSet Function() object({
    String actor = 'ana',
    String comment = 'yo no fui',
    DebtStatus status = DebtStatus.pending,
  }) =>
      () => ObjectDebt(sequentialIds())(
        actorId: actor,
        debt: buildDebt(status: status),
        order: buildOrder(),
        comment: comment,
        now: t0,
      );

  test('leaves the debt untouched and warns the creditor (D5)', () {
    final changes = object()();

    expect(changes.debts, isEmpty);
    expect(changes.ledger.single.type, LedgerEventType.debtObjected);
    expect(changes.ledger.single.note, 'yo no fui');
    final notification = changes.notifications.single;
    expect(notification.kind, NotificationKind.debtObjected);
    expect(notification.recipientId, 'omar');
    expect(notification.note, 'yo no fui');
  });

  test('requires a comment within the length limit', () {
    expect(
      object(comment: '  '),
      throwsOrder(OrderFailureReason.commentRequired),
    );
    expect(
      object(comment: 'x' * 201),
      throwsOrder(OrderFailureReason.commentTooLong),
    );
  });

  test('only the debtor objects, and only while pending', () {
    expect(object(actor: 'omar'), throwsOrder(OrderFailureReason.notDebtor));
    expect(
      object(status: DebtStatus.confirmed),
      throwsOrder(OrderFailureReason.invalidTransition),
    );
  });
}
