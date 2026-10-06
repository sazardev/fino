import 'package:fino/core/money/money.dart';
import 'package:fino/features/orders/domain/entities/ledger_entry.dart';
import 'package:fino/features/orders/domain/entities/payout_snapshot.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/enums/order_status.dart';
import 'package:fino/features/orders/domain/failures/order_failure.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/views/debt_book.dart';
import 'package:fino/features/orders/domain/views/ledger_visibility.dart';
import 'package:fino/features/orders/domain/views/order_summary.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  group('DebtStatus', () {
    test('only pending and reported debts are live', () {
      expect(DebtStatus.pending.isLive, isTrue);
      expect(DebtStatus.paymentReported.isLive, isTrue);
      expect(DebtStatus.confirmed.isLive, isFalse);
      expect(DebtStatus.cancelled.isLive, isFalse);
    });

    test('cancelled debts are not active', () {
      expect(DebtStatus.confirmed.isActive, isTrue);
      expect(DebtStatus.cancelled.isActive, isFalse);
    });
  });

  group('OrderStatus.fromDebts (SPEC 5.4)', () {
    OrderStatus of(List<DebtStatus> statuses) =>
        OrderStatus.fromDebts(statuses);

    test('open while any debt is live', () {
      expect(
        of([DebtStatus.confirmed, DebtStatus.paymentReported]),
        OrderStatus.open,
      );
    });

    test('settled with no live debts and one confirmed', () {
      expect(
        of([DebtStatus.confirmed, DebtStatus.cancelled]),
        OrderStatus.settled,
      );
    });

    test('cancelled when every debt is cancelled', () {
      expect(of([DebtStatus.cancelled]), OrderStatus.cancelled);
    });
  });

  group('OrderSummary', () {
    final summary = OrderSummary(buildOrder(), [
      buildDebt(status: DebtStatus.confirmed),
      buildDebt(id: 'd2', debtorId: 'beto'),
      buildDebt(id: 'd3', debtorId: 'cris', status: DebtStatus.cancelled),
    ]);

    test('derives status, progress and the creditor share', () {
      expect(summary.status, OrderStatus.open);
      expect(summary.progress, (confirmed: 1, total: 2));
      expect(summary.creditorShare, pesos(180));
    });
  });

  group('DebtBook (SPEC 7.2)', () {
    final book = DebtBook('ana', [
      buildDebt(),
      buildDebt(
        id: 'd2',
        orderId: 'o2',
        amount: pesos(85),
        status: DebtStatus.paymentReported,
      ),
      buildDebt(id: 'd3', status: DebtStatus.confirmed),
      buildDebt(id: 'd4', creditorId: 'luis', amount: pesos(10)),
      buildDebt(
        id: 'd5',
        creditorId: 'ana',
        debtorId: 'omar',
        amount: pesos(40),
      ),
      buildDebt(
        id: 'd6',
        creditorId: 'ana',
        debtorId: 'omar',
        amount: pesos(5),
      ),
    ]);

    test('groups what I owe by creditor and skips closed debts', () {
      expect(book.iOwe.map((g) => g.counterpartyId), ['omar', 'luis']);
      final omar = book.iOwe.first;
      expect(omar.total, pesos(145));
      expect(omar.payable.map((d) => d.id), ['d1']);
      expect(omar.awaitingConfirmation.map((d) => d.id), ['d2']);
      expect(book.totalIOwe, pesos(155));
    });

    test('groups what I am owed by debtor, without netting (6.7)', () {
      expect(book.owedToMe.single.counterpartyId, 'omar');
      expect(book.totalOwedToMe, pesos(45));
    });
  });

  group('LedgerVisibility (SPEC 7.1)', () {
    LedgerEntry entry(LedgerEventType type) => LedgerEntry(
      id: 'e1',
      orderId: 'o1',
      type: type,
      actorId: 'ana',
      at: t0,
    );
    final debt = buildDebt();

    bool canView(LedgerEventType type, String viewer, {bool withDebt = true}) =>
        LedgerVisibility.canView(
          entry: entry(type),
          viewerId: viewer,
          debt: withDebt ? debt : null,
        );

    test('any member sees ordinary entries', () {
      expect(canView(LedgerEventType.debtCancelled, 'beto'), isTrue);
    });

    test('references and objections are for the two parties only', () {
      expect(canView(LedgerEventType.paymentReported, 'omar'), isTrue);
      expect(canView(LedgerEventType.debtObjected, 'ana'), isTrue);
      expect(canView(LedgerEventType.paymentReported, 'beto'), isFalse);
      expect(
        canView(LedgerEventType.debtObjected, 'omar', withDebt: false),
        isFalse,
      );
    });
  });

  test('payout snapshots compare by value', () {
    const snapshot = PayoutSnapshot(bankName: 'BBVA', last4: '1234');

    expect(snapshot, const PayoutSnapshot(bankName: 'BBVA', last4: '1234'));
    expect(snapshot.hashCode, snapshot.hashCode);
    expect(snapshot, isNot(const PayoutSnapshot(last4: '1234')));
    expect(snapshot.toString(), contains('1234'));
  });

  test('failures and values describe themselves', () {
    expect(
      const OrderFailure(OrderFailureReason.notCreditor).toString(),
      'OrderFailure(notCreditor)',
    );
    expect(Money.zero.isZero, isTrue);
  });
}
