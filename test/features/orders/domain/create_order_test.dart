import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/split/split_entry.dart';
import 'package:fino/features/orders/domain/use_cases/create_order.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  final members = {'omar', 'ana', 'beto'};

  OrderChangeSet Function() create({
    Set<String>? memberIds,
    bool hasMethod = true,
    String concept = ' Café ',
    List<SplitEntry>? entries,
  }) =>
      () => CreateOrder(sequentialIds())(
        creditorId: 'omar',
        teamId: 't1',
        memberIds: memberIds ?? members,
        creditorHasPayoutMethod: hasMethod,
        concept: concept,
        total: pesos(300),
        spentAt: t0,
        creditorIncluded: false,
        entries: entries ?? [const SplitEntry('ana'), const SplitEntry('beto')],
        now: t0,
        note: '  ',
      );

  test('creates the order, its pending debts, ledger and notifications', () {
    final changes = create()();
    final order = changes.order!;

    expect(order.concept, 'Café');
    expect(order.note, isNull);
    expect(order.creditorId, 'omar');
    expect(
      changes.debts.map((d) => d.status),
      everyElement(DebtStatus.pending),
    );
    expect(changes.debts.map((d) => d.amount), everyElement(pesos(150)));
    expect(changes.debts.map((d) => d.orderId), everyElement(order.id));

    expect(changes.ledger.first.type, LedgerEventType.orderCreated);
    expect(changes.ledger, hasLength(3));

    expect(changes.notifications, hasLength(2));
    final first = changes.notifications.first;
    expect(first.kind, NotificationKind.orderDebtCreated);
    expect(first.recipientId, 'ana');
    expect(first.amount, pesos(150));
    expect(first.concept, 'Café');
    expect(first.target, NotificationTarget.debt(changes.debts.first.id));
  });

  test('rejects an order without the creditor payout method (M2)', () {
    expect(
      create(hasMethod: false),
      throwsOrder(OrderFailureReason.creditorWithoutPayoutMethod),
    );
  });

  test('rejects debtors that are not members', () {
    expect(
      create(entries: [const SplitEntry('intruso')]),
      throwsOrder(OrderFailureReason.notTeamMember),
    );
  });

  test('rejects a creditor that is not a member', () {
    expect(
      create(memberIds: {'ana', 'beto'}),
      throwsOrder(OrderFailureReason.notTeamMember),
    );
  });

  test('rejects an empty or too long concept', () {
    expect(
      create(concept: '  '),
      throwsOrder(OrderFailureReason.conceptRequired),
    );
    expect(
      create(concept: 'x' * 81),
      throwsOrder(OrderFailureReason.conceptTooLong),
    );
  });
}
