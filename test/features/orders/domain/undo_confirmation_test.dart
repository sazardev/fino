import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/use_cases/undo_confirmation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  final order = buildOrder();
  final confirmed = buildDebt(status: DebtStatus.confirmed, paymentId: 'p1');

  void Function() undo({
    String actor = 'omar',
    DebtStatus status = DebtStatus.confirmed,
    bool debtorIsMember = true,
  }) =>
      () => UndoConfirmation(sequentialIds())(
        actorId: actor,
        debt: confirmed.copyWith(status: status),
        order: order,
        debtorIsMember: debtorIsMember,
        now: t0,
      );

  test('a confirmed debt goes back to "payment reported" (D4)', () {
    final changes = UndoConfirmation(sequentialIds())(
      actorId: 'omar',
      debt: confirmed,
      order: order,
      debtorIsMember: true,
      now: t0,
    );

    expect(changes.debts.single.status, DebtStatus.paymentReported);
    expect(changes.debts.single.paymentId, 'p1');
    expect(changes.ledger.single.type, LedgerEventType.confirmationUndone);
    final notification = changes.notifications.single;
    expect(notification.kind, NotificationKind.confirmationUndone);
    expect(notification.recipientId, 'ana');
    expect(notification.concept, 'Café');
  });

  test('undoing what is already awaiting confirmation is a no-op', () {
    final changes = UndoConfirmation(sequentialIds())(
      actorId: 'omar',
      debt: confirmed.copyWith(status: DebtStatus.paymentReported),
      order: order,
      debtorIsMember: true,
      now: t0,
    );

    expect(changes.isEmpty, isTrue);
  });

  test('only a confirmation can be undone', () {
    expect(
      undo(status: DebtStatus.pending),
      throwsOrder(OrderFailureReason.invalidTransition),
    );
  });

  test('not possible once the debtor left the team', () {
    expect(
      undo(debtorIsMember: false),
      throwsOrder(OrderFailureReason.debtorLeftTeam),
    );
  });

  test('only the creditor can undo', () {
    expect(undo(actor: 'ana'), throwsOrder(OrderFailureReason.notCreditor));
  });
}
