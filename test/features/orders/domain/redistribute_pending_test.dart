import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/split/split_entry.dart';
import 'package:fino/features/orders/domain/use_cases/redistribute_pending.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  final order = buildOrder(total: pesos(1000));
  final debts = [
    buildDebt(amount: pesos(250), status: DebtStatus.confirmed),
    buildDebt(id: 'd2', debtorId: 'beto', amount: pesos(250)),
    buildDebt(id: 'd3', debtorId: 'cris', amount: pesos(250)),
    buildDebt(
      id: 'd4',
      debtorId: 'dani',
      amount: pesos(250),
      status: DebtStatus.cancelled,
    ),
  ];

  OrderChangeSet Function() redistribute(
    List<SplitEntry> entries, {
    List<Debt>? current,
    bool creditorIncluded = false,
  }) =>
      () => RedistributePending(sequentialIds())(
        actorId: 'omar',
        order: order,
        debts: current ?? debts,
        creditorIncluded: creditorIncluded,
        entries: entries,
        now: t0,
      );

  test('re-splits only what is pending, frozen debts count as fixed', () {
    final changes = redistribute([
      const SplitEntry('beto'),
      SplitEntry('cris', fixedAmount: pesos(100)),
    ])();

    // 1000 − 250 confirmed = 750; cris fixed 100 → beto 650.
    expect(changes.debts.map((d) => d.debtorId), ['beto', 'cris']);
    expect(changes.debts.map((d) => d.amount), [pesos(650), pesos(100)]);
    expect(changes.ledger.first.type, LedgerEventType.orderRedistributed);
    expect(
      changes.ledger.skip(1).map((e) => e.type),
      everyElement(LedgerEventType.debtAmountChanged),
    );
    expect(changes.ledger[1].amountBefore, pesos(250));
    expect(
      changes.notifications.map((n) => n.kind),
      everyElement(NotificationKind.debtAmountChanged),
    );
  });

  test('only the debts whose amount changed are touched', () {
    final changes = redistribute([
      const SplitEntry('beto'),
      SplitEntry('cris', fixedAmount: pesos(250)),
    ])();

    expect(changes.debts.single.debtorId, 'beto');
    expect(changes.debts.single.amount, pesos(500));
  });

  test('nothing changes when the split already matches', () {
    final even = [
      debts.first,
      debts[1].copyWith(amount: pesos(375)),
      debts[2].copyWith(amount: pesos(375)),
    ];

    final changes = redistribute([
      const SplitEntry('beto'),
      const SplitEntry('cris'),
    ], current: even)();

    expect(changes.isEmpty, isTrue);
  });

  test('entries must name exactly the pending debtors', () {
    expect(
      redistribute([const SplitEntry('beto')]),
      throwsOrder(OrderFailureReason.participantsMismatch),
    );
    expect(
      redistribute([const SplitEntry('beto'), const SplitEntry('dani')]),
      throwsOrder(OrderFailureReason.participantsMismatch),
    );
  });

  test('only the creditor redistributes', () {
    expect(
      () => RedistributePending(sequentialIds())(
        actorId: 'ana',
        order: order,
        debts: debts,
        creditorIncluded: false,
        entries: [const SplitEntry('beto'), const SplitEntry('cris')],
        now: t0,
      ),
      throwsOrder(OrderFailureReason.notCreditor),
    );
  });
}
