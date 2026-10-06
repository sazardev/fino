import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/orders/domain/entities/payment.dart';
import 'package:fino/features/orders/domain/entities/payout_snapshot.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/use_cases/find_stale_payments.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  const finder = FindStalePayments();
  final payment = Payment(
    id: 'p1',
    teamId: 't1',
    creditorId: 'omar',
    debtorId: 'ana',
    debtIds: const ['d1'],
    payoutShown: const PayoutSnapshot(last4: '1234'),
    reportedAt: t0,
  );
  final waiting = buildDebt(
    status: DebtStatus.paymentReported,
    paymentId: 'p1',
  );
  final later = t0.add(const Duration(hours: 49));

  test('warns the creditor once after 48 hours without confirming (#13)', () {
    final changes = finder(payments: [payment], debts: [waiting], now: later);

    expect(changes.payments.single.awaitingConfirmationReminderSent, isTrue);
    final notification = changes.notifications.single;
    expect(notification.kind, NotificationKind.paymentAwaitingConfirmation);
    expect(notification.recipientId, 'omar');
    expect(notification.amount, pesos(60));
    expect(notification.debtCount, 1);
  });

  test('does not warn before the threshold', () {
    final soon = t0.add(const Duration(hours: 47));

    expect(
      finder(payments: [payment], debts: [waiting], now: soon).isEmpty,
      isTrue,
    );
  });

  test('does not warn twice for the same payment', () {
    final sent = payment.copyWith(awaitingConfirmationReminderSent: true);

    expect(
      finder(payments: [sent], debts: [waiting], now: later).isEmpty,
      isTrue,
    );
  });

  test('does not warn when nothing is waiting anymore', () {
    final confirmed = waiting.copyWith(status: DebtStatus.confirmed);

    expect(
      finder(payments: [payment], debts: [confirmed], now: later).isEmpty,
      isTrue,
    );
  });
}
