import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/enums/review_decision.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/use_cases/debt_review.dart';
import 'package:fino/features/orders/domain/use_cases/review_debts.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  final cafe = buildOrder();
  Debt reported(String id, {String debtor = 'ana', int amount = 60}) =>
      buildDebt(
        id: id,
        debtorId: debtor,
        amount: pesos(amount),
        status: DebtStatus.paymentReported,
        paymentId: 'p-$debtor',
      );

  OrderChangeSet Function() review(
    List<DebtReview> reviews, {
    String actor = 'omar',
  }) =>
      () => ReviewDebts(sequentialIds())(
        actorId: actor,
        reviews: reviews,
        orders: {cafe.id: cafe},
        now: t0,
      );

  DebtReview confirm(Debt debt) => DebtReview(debt, ReviewDecision.confirm);
  DebtReview reject(Debt debt, {String? note}) =>
      DebtReview(debt, ReviewDecision.reject, note: note);

  test('confirms everything at once with one summary per debtor (G5, G6)', () {
    final changes = review([
      confirm(reported('d1')),
      confirm(reported('d2', amount: 85)),
      confirm(reported('d3', debtor: 'beto')),
    ])();

    expect(
      changes.debts.map((d) => d.status),
      everyElement(DebtStatus.confirmed),
    );
    expect(
      changes.ledger.map((e) => e.type),
      everyElement(LedgerEventType.paymentConfirmed),
    );
    expect(changes.notifications, hasLength(2));
    final forAna = changes.notifications.first;
    expect(forAna.kind, NotificationKind.paymentReviewed);
    expect(forAna.recipientId, 'ana');
    expect(forAna.debtCount, 2);
    expect(forAna.rejectedCount, 0);
    expect(forAna.amount, pesos(145));
    expect(forAna.target, const NotificationTarget.payment('p-ana'));
  });

  test('confirming some and rejecting others in the same payment', () {
    final changes = review([
      confirm(reported('d1')),
      reject(reported('d2', amount: 85), note: 'no me llegó'),
    ])();

    final confirmed = changes.debts.firstWhere((d) => d.id == 'd1');
    final rejected = changes.debts.firstWhere((d) => d.id == 'd2');
    expect(confirmed.status, DebtStatus.confirmed);
    expect(rejected.status, DebtStatus.pending);
    expect(rejected.paymentId, isNull);
    final notification = changes.notifications.single;
    expect(notification.debtCount, 1);
    expect(notification.rejectedCount, 1);
    expect(notification.amount, pesos(60));
    expect(notification.note, 'no me llegó');
    expect(
      changes.ledger.map((e) => e.type),
      contains(LedgerEventType.paymentRejected),
    );
  });

  test('repeating the same decision is a no-op (SPEC 10.20)', () {
    final confirmed = reported('d1').copyWith(status: DebtStatus.confirmed);
    final pending = reported('d2')
        .copyWith(status: DebtStatus.pending, paymentId: null);

    expect(review([confirm(confirmed), reject(pending)])().isEmpty, isTrue);
  });

  test('falls back to the debt when no payment is linked', () {
    final orphan = reported('d1').copyWith(paymentId: null);

    final changes = review([confirm(orphan)])();

    expect(
      changes.notifications.single.target,
      const NotificationTarget.debt('d1'),
    );
  });

  test('only a reported debt can be confirmed or rejected', () {
    final pending = buildDebt();
    final confirmed = reported('d1').copyWith(status: DebtStatus.confirmed);

    expect(
      review([confirm(pending)]),
      throwsOrder(OrderFailureReason.invalidTransition),
    );
    expect(
      review([reject(confirmed)]),
      throwsOrder(OrderFailureReason.invalidTransition),
    );
  });

  test('only the creditor reviews, and something must be selected', () {
    expect(
      review([confirm(reported('d1'))], actor: 'ana'),
      throwsOrder(OrderFailureReason.notCreditor),
    );
    expect(review(const []), throwsOrder(OrderFailureReason.emptySelection));
  });
}
