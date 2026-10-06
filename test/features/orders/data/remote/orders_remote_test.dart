import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/features/orders/data/remote/debt_remote_mapper.dart';
import 'package:fino/features/orders/data/remote/ledger_entry_remote_mapper.dart';
import 'package:fino/features/orders/data/remote/order_remote_mapper.dart';
import 'package:fino/features/orders/data/remote/order_write_planner.dart';
import 'package:fino/features/orders/data/remote/payment_remote_mapper.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/ledger_entry.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/entities/payment.dart';
import 'package:fino/features/orders/domain/entities/payout_snapshot.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/resolve_markers.dart';
import '../../domain/support/order_fixtures.dart';

void main() {
  group('documents', () {
    test('an order round-trips; its dates are stamped by the server', () {
      final order = buildOrder().copyWith(note: 'con leche');

      final fields = OrderRemoteMapper.toCreateFields(order);

      expect(fields['createdAt'], RemoteMarker.serverTimestamp);
      expect(fields['updatedAt'], RemoteMarker.serverTimestamp);
      expect(fields['total'], 30000);
      expect(
        OrderRemoteMapper.fromFields('o1', 't1', resolveMarkers(fields, t0)),
        order,
      );
    });

    test('an order without note omits it; updates delete it', () {
      final order = buildOrder();

      expect(OrderRemoteMapper.toCreateFields(order), isNot(contains('note')));
      expect(
        OrderRemoteMapper.toUpdateFields(order)['note'],
        RemoteMarker.fieldDelete,
      );
      expect(
        OrderRemoteMapper.toUpdateFields(order.copyWith(note: 'x'))['note'],
        'x',
      );
    });

    test('a debt round-trips and its update drops the payment when none', () {
      final reported = buildDebt(
        status: DebtStatus.paymentReported,
        paymentId: 'p1',
      );

      expect(
        DebtRemoteMapper.fromFields(
          'd1',
          't1',
          resolveMarkers(DebtRemoteMapper.toCreateFields(reported), t0)
            ..['paymentId'] = 'p1'
            ..['status'] = 'paymentReported',
        ),
        reported,
      );
      expect(DebtRemoteMapper.toUpdateFields(reported)['paymentId'], 'p1');
      expect(
        DebtRemoteMapper.toUpdateFields(buildDebt())['paymentId'],
        RemoteMarker.fieldDelete,
      );
    });

    test('a payment round-trips with its snapshot', () {
      final payment = Payment(
        id: 'p1',
        teamId: 't1',
        creditorId: 'omar',
        debtorId: 'ana',
        debtIds: const ['d1', 'd2'],
        payoutShown: const PayoutSnapshot(bankName: 'BBVA', last4: '5671'),
        reportedAt: t0,
        reference: 'SPEI-1',
      );

      final fields = PaymentRemoteMapper.toCreateFields(payment);

      expect(fields['reportedAt'], RemoteMarker.serverTimestamp);
      expect(
        PaymentRemoteMapper.fromFields('p1', 't1', resolveMarkers(fields, t0)),
        payment,
      );
      expect(PaymentRemoteMapper.toReminderFields(), {
        'awaitingConfirmationReminderSent': true,
      });
    });

    test('a payment without bank or reference leaves them out', () {
      final fields = PaymentRemoteMapper.toCreateFields(
        Payment(
          id: 'p1',
          teamId: 't1',
          creditorId: 'omar',
          debtorId: 'ana',
          debtIds: const ['d1'],
          payoutShown: const PayoutSnapshot(last4: '5671'),
          reportedAt: t0,
        ),
      );

      expect(fields, isNot(contains('reference')));
      expect(fields['payoutShown'], {'last4': '5671'});
    });

    test('a ledger line flags confidential types and carries its parties', () {
      final entry = LedgerEntry(
        id: 'l1',
        orderId: 'o1',
        type: LedgerEventType.paymentReported,
        actorId: 'ana',
        at: t0,
        debtId: 'd1',
        paymentId: 'p1',
        amountBefore: const Money(6000),
        amountAfter: const Money(4000),
        note: 'SPEI-1',
      );

      final fields = LedgerEntryRemoteMapper.toCreateFields(
        entry,
        partyIds: ['omar', 'ana'],
      );

      expect(fields['confidential'], isTrue);
      expect(fields['partyIds'], ['omar', 'ana']);
      expect(
        LedgerEntryRemoteMapper.fromFields('l1', resolveMarkers(fields, t0)),
        entry,
      );
      expect(
        LedgerEntryRemoteMapper.toCreateFields(
          entry.copyWith(type: LedgerEventType.debtAdded),
          partyIds: const [],
        )['confidential'],
        isFalse,
      );
    });
  });

  group('OrderWritePlanner', () {
    const planner = OrderWritePlanner();
    final order = buildOrder();
    final debt = buildDebt();

    List<RemoteWrite> plan(
      OrderChangeSet changes, {
      KnownIds known = const KnownIds(),
      Map<String, Debt> debtsById = const {},
      Set<String> live = const {},
      String actor = 'omar',
    }) => planner.plan(
      changes,
      actorId: actor,
      teamId: 't1',
      known: known,
      debtsById: debtsById,
      liveDebtorIdsAfter: live,
    );

    test('new documents are created, existing ones updated', () {
      final changes = OrderChangeSet(order: order, debts: [debt]);

      final fresh = plan(changes, live: {'ana'});
      final known = plan(
        changes,
        known: KnownIds(orders: {order.id}, debts: {debt.id}),
        live: {'ana'},
      );

      expect(fresh.map((w) => (w.path, w.operation)), [
        ('teams/t1/orders/o1', OutboxOperation.create),
        ('teams/t1/debts/d1', OutboxOperation.create),
        ('teams/t1/members/omar/payers/ana', OutboxOperation.set),
      ]);
      expect(known.first.operation, OutboxOperation.update);
      expect(known[1].operation, OutboxOperation.update);
      expect(known[1].fields, contains('paymentId'));
    });

    test('a known payment only flags the reminder', () {
      final payment = Payment(
        id: 'p1',
        teamId: 't1',
        creditorId: 'omar',
        debtorId: 'ana',
        debtIds: const ['d1'],
        payoutShown: const PayoutSnapshot(last4: '5671'),
        reportedAt: t0,
        awaitingConfirmationReminderSent: true,
      );

      final writes = plan(
        OrderChangeSet(payments: [payment]),
        known: const KnownIds(payments: {'p1'}),
      );

      expect(writes.single.operation, OutboxOperation.update);
      expect(writes.single.fields, {'awaitingConfirmationReminderSent': true});
    });

    test('ledger lines get the parties of their debt', () {
      final entry = LedgerEntry(
        id: 'l1',
        orderId: 'o1',
        type: LedgerEventType.debtObjected,
        actorId: 'ana',
        at: t0,
        debtId: 'd1',
        note: 'yo no fui',
      );

      final writes = plan(
        OrderChangeSet(
          ledger: [
            entry,
            entry.copyWith(debtId: null, id: 'l2'),
          ],
        ),
        debtsById: {'d1': debt},
        actor: 'ana',
      );

      expect(writes.first.fields['partyIds'], ['omar', 'ana']);
      expect(writes.last.fields['partyIds'], isEmpty);
    });

    test(
      'markers: closed debts withdraw access, debtors act without markers',
      () {
        final confirmed = debt.copyWith(status: DebtStatus.confirmed);

        final byCreditor = plan(
          OrderChangeSet(debts: [confirmed]),
          known: KnownIds(debts: {debt.id}),
        );
        final byDebtor = plan(
          OrderChangeSet(debts: [debt]),
          known: KnownIds(debts: {debt.id}),
          actor: 'ana',
        );

        expect(byCreditor.last.operation, OutboxOperation.delete);
        expect(byCreditor.last.path, 'teams/t1/members/omar/payers/ana');
        expect(
          byDebtor.map((w) => w.collection),
          isNot(contains(contains('payers'))),
        );
      },
    );
  });
}
