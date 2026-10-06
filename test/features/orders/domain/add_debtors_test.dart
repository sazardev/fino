import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/use_cases/add_debtors.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  final order = buildOrder();
  final members = {'omar', 'ana', 'beto', 'cris'};

  OrderChangeSet Function() add(
    Map<String, Money> newDebtors, {
    List<Debt>? debts,
    String actor = 'omar',
  }) =>
      () => AddDebtors(sequentialIds())(
        actorId: actor,
        order: order,
        debts: debts ?? [buildDebt()],
        memberIds: members,
        newDebtors: newDebtors,
        now: t0,
      );

  test('adds pending debts to an open order and warns the new debtors', () {
    final changes = add({'beto': pesos(100), 'cris': pesos(50)})();

    expect(changes.debts.map((d) => d.debtorId), ['beto', 'cris']);
    expect(
      changes.debts.map((d) => d.status),
      everyElement(DebtStatus.pending),
    );
    expect(changes.ledger, hasLength(2));
    expect(
      changes.notifications.map((n) => n.kind),
      everyElement(NotificationKind.debtAddedToOrder),
    );
    expect(changes.notifications.first.amount, pesos(100));
  });

  test('someone whose debt was cancelled can be added again (P6)', () {
    final changes = add(
      {'ana': pesos(50)},
      debts: [
        buildDebt(status: DebtStatus.cancelled),
        buildDebt(id: 'd2', debtorId: 'beto'),
      ],
    )();

    expect(changes.debts.single.debtorId, 'ana');
  });

  test('rejects a closed order', () {
    expect(
      add(
        {'beto': pesos(10)},
        debts: [buildDebt(status: DebtStatus.confirmed)],
      ),
      throwsOrder(OrderFailureReason.orderNotOpen),
    );
  });

  test('rejects duplicates, the creditor and non-members', () {
    expect(
      add({'ana': pesos(10)}),
      throwsOrder(OrderFailureReason.duplicateParticipant),
    );
    expect(
      add({'omar': pesos(10)}),
      throwsOrder(OrderFailureReason.creditorCannotOwe),
    );
    expect(
      add({'intruso': pesos(10)}),
      throwsOrder(OrderFailureReason.notTeamMember),
    );
  });

  test('rejects empty input, bad amounts and sums above the total', () {
    expect(add(const {}), throwsOrder(OrderFailureReason.noDebtors));
    expect(
      add({'beto': Money.zero}),
      throwsOrder(OrderFailureReason.amountNotPositive),
    );
    expect(
      add({'beto': pesos(300)}),
      throwsOrder(OrderFailureReason.sumExceedsTotal),
    );
  });

  test('only the creditor adds debtors', () {
    expect(
      add({'beto': pesos(10)}, actor: 'ana'),
      throwsOrder(OrderFailureReason.notCreditor),
    );
  });
}
