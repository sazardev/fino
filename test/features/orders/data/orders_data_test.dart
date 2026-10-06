import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/features/orders/data/mappers/debt_mapper.dart';
import 'package:fino/features/orders/data/mappers/ledger_entry_mapper.dart';
import 'package:fino/features/orders/data/mappers/order_mapper.dart';
import 'package:fino/features/orders/data/mappers/payment_mapper.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/ledger_entry.dart';
import 'package:fino/features/orders/domain/entities/order.dart';
import 'package:fino/features/orders/domain/entities/payment.dart';
import 'package:fino/features/orders/domain/entities/payout_snapshot.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  final at = DateTime.utc(2026, 10, 6, 12);

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Order order(String id, {DateTime? spent, String teamId = 't1'}) => Order(
    id: id,
    teamId: teamId,
    creditorId: 'omar',
    concept: 'Café',
    note: 'con leche',
    total: const Money(30000),
    spentAt: spent ?? at,
    createdAt: at,
    updatedAt: at,
  );

  Debt debt(
    String id, {
    String orderId = 'o1',
    String debtor = 'ana',
    String creditor = 'omar',
    DebtStatus status = DebtStatus.pending,
    String teamId = 't1',
    String? paymentId,
  }) => Debt(
    id: id,
    orderId: orderId,
    teamId: teamId,
    creditorId: creditor,
    debtorId: debtor,
    amount: const Money(6000),
    status: status,
    createdAt: at,
    updatedAt: at,
    paymentId: paymentId,
  );

  Future<void> saveDebts(List<Debt> debts) =>
      db.debtsDao.upsertDebts(debts.map(DebtMapper.toCompanion));

  group('orders', () {
    test('an order round-trips, including cents and note', () async {
      await db.ordersDao.upsertOrder(OrderMapper.toCompanion(order('o1')));

      final row = await db.ordersDao.findOrder('o1');

      expect(OrderMapper.toDomain(row!), order('o1'));
      expect(await db.ordersDao.findOrder('nope'), isNull);
    });

    test('team orders list the latest expense first', () async {
      for (final o in [
        order('old', spent: at),
        order('new', spent: at.add(const Duration(days: 1))),
        order('other', teamId: 't2'),
      ]) {
        await db.ordersDao.upsertOrder(OrderMapper.toCompanion(o));
      }

      final listed = await db.ordersDao.watchTeamOrders('t1').first;

      expect(listed.map((o) => o.id), ['new', 'old']);
      expect(
        (await db.ordersDao.findOrders(['old', 'other'])).map((o) => o.id),
        unorderedEquals(['old', 'other']),
      );
    });

    test('upserting again updates the order', () async {
      await db.ordersDao.upsertOrder(OrderMapper.toCompanion(order('o1')));
      await db.ordersDao.upsertOrder(
        OrderMapper.toCompanion(order('o1').copyWith(concept: 'Comida')),
      );

      expect((await db.ordersDao.findOrder('o1'))!.concept, 'Comida');
    });

    test('the creditor sees the orders they created', () async {
      await db.ordersDao.upsertOrder(OrderMapper.toCompanion(order('o1')));

      expect((await db.ordersDao.watchCreatedBy('omar').first).length, 1);
      expect(await db.ordersDao.watchCreatedBy('ana').first, isEmpty);
    });
  });

  group('debts (SPEC 7.2)', () {
    test('a debt round-trips with its status and payment', () async {
      final saved = debt(
        'd1',
        status: DebtStatus.paymentReported,
        paymentId: 'p1',
      );
      await saveDebts([saved]);

      expect(DebtMapper.toDomain((await db.debtsDao.findDebt('d1'))!), saved);
    });

    test(
      'live debts feed Debo / Me deben; closed ones go to history',
      () async {
        await saveDebts([
          debt('d1'),
          debt('d2', status: DebtStatus.paymentReported, paymentId: 'p1'),
          debt('d3', status: DebtStatus.confirmed),
          debt('d4', status: DebtStatus.cancelled),
          debt('d5', debtor: 'beto', creditor: 'luis'),
        ]);

        final ana = await db.debtsDao.watchLiveDebtsOf('ana').first;
        final omar = await db.debtsDao.watchLiveDebtsOf('omar').first;
        final history = await db.debtsDao.watchClosedDebtsOf('ana').first;

        expect(ana.map((d) => d.id), ['d1', 'd2']);
        expect(omar.map((d) => d.id), ['d1', 'd2']);
        expect(history.map((d) => d.id), unorderedEquals(['d3', 'd4']));
      },
    );

    test('team and order views', () async {
      await saveDebts([
        debt('d1'),
        debt('d2', orderId: 'o2', debtor: 'beto'),
        debt('d3', orderId: 'o3', teamId: 't2'),
      ]);

      expect(
        (await db.debtsDao.watchTeamDebts('t1').first).map((d) => d.id),
        unorderedEquals(['d1', 'd2']),
      );
      expect((await db.debtsDao.watchDebtsOfOrder('o2').first).single.id, 'd2');
      expect((await db.debtsDao.debtsOfOrder('o1')).map((d) => d.id), ['d1']);
      expect((await db.debtsDao.findDebts(['d1', 'd3'])).length, 2);
    });

    test('debts of a payment', () async {
      await saveDebts([
        debt('d1', status: DebtStatus.paymentReported, paymentId: 'p1'),
        debt('d2', status: DebtStatus.paymentReported, paymentId: 'p1'),
        debt('d3'),
      ]);

      expect(
        (await db.debtsDao.debtsOfPayment('p1')).map((d) => d.id),
        unorderedEquals(['d1', 'd2']),
      );
    });

    test('live counts per role block leaving a team (SPEC 4.2)', () async {
      await saveDebts([
        debt('d1'),
        debt('d2', debtor: 'beto'),
        debt('d3', status: DebtStatus.confirmed),
        debt('d4', debtor: 'omar', creditor: 'ana'),
        debt('d5', teamId: 't2'),
      ]);

      expect(await db.debtsDao.liveCounts('omar', 't1'), (
        asDebtor: 1,
        asCreditor: 2,
      ));
      expect(await db.debtsDao.liveCounts('ana', 't1'), (
        asDebtor: 1,
        asCreditor: 1,
      ));
      expect(await db.debtsDao.liveCountOfTeam('t1'), 3);
      expect(await db.debtsDao.liveCountOfTeam('empty'), 0);
    });
  });

  group('payments', () {
    Payment payment(
      String id, {
      bool reminded = false,
      String creditor = 'omar',
    }) => Payment(
      id: id,
      teamId: 't1',
      creditorId: creditor,
      debtorId: 'ana',
      debtIds: const ['d1', 'd2'],
      payoutShown: const PayoutSnapshot(bankName: 'BBVA', last4: '5671'),
      reportedAt: at,
      awaitingConfirmationReminderSent: reminded,
      reference: 'SPEI-1',
    );

    test('a payment keeps its debt list and snapshot', () async {
      await db.paymentsDao.upsertPayments([
        PaymentMapper.toCompanion(payment('p1')),
      ]);

      final row = await db.paymentsDao.findPayment('p1');

      expect(PaymentMapper.toDomain(row!), payment('p1'));
    });

    test(
      'only unreminded payments to the creditor are pending reminders',
      () async {
        await db.paymentsDao.upsertPayments([
          PaymentMapper.toCompanion(payment('p1')),
          PaymentMapper.toCompanion(payment('p2', reminded: true)),
          PaymentMapper.toCompanion(payment('p3', creditor: 'luis')),
        ]);

        final pending = await db.paymentsDao.pendingReminders('omar');

        expect(pending.map((p) => p.id), ['p1']);
        expect((await db.paymentsDao.watchTeamPayments('t1').first).length, 3);
      },
    );
  });

  group('ledger', () {
    LedgerEntry entry(String id, DateTime when, {bool amounts = false}) =>
        LedgerEntry(
          id: id,
          orderId: 'o1',
          type: LedgerEventType.debtAmountChanged,
          actorId: 'omar',
          at: when,
          debtId: 'd1',
          amountBefore: amounts ? const Money(6000) : null,
          amountAfter: amounts ? const Money(4000) : null,
          note: 'ajuste',
        );

    test('the timeline is ordered and keeps amounts', () async {
      await db.ledgerDao.insertEntries([
        LedgerEntryMapper.toCompanion(
          entry('b', at.add(const Duration(minutes: 1)), amounts: true),
          teamId: 't1',
          partyIds: ['omar', 'ana'],
        ),
        LedgerEntryMapper.toCompanion(
          entry('a', at),
          teamId: 't1',
          partyIds: ['omar', 'ana'],
        ),
      ]);

      final rows = await db.ledgerDao.watchOrderTimeline('o1').first;
      final mapped = rows.map(LedgerEntryMapper.toDomain).toList();

      expect(mapped.map((e) => e.id), ['a', 'b']);
      expect(mapped.last.amountBefore, const Money(6000));
      expect(mapped.first.amountBefore, isNull);
      expect(rows.last.partyIds, ['omar', 'ana']);
    });
  });

  test(
    'deleting a team removes its orders, debts, payments and ledger',
    () async {
      await db.ordersDao.upsertOrder(OrderMapper.toCompanion(order('o1')));
      await saveDebts([debt('d1')]);
      await db.paymentsDao.upsertPayments([
        PaymentMapper.toCompanion(
          Payment(
            id: 'p1',
            teamId: 't1',
            creditorId: 'omar',
            debtorId: 'ana',
            debtIds: const ['d1'],
            payoutShown: const PayoutSnapshot(last4: '5671'),
            reportedAt: at,
          ),
        ),
      ]);
      await db.ledgerDao.insertEntries([
        LedgerEntryMapper.toCompanion(
          LedgerEntry(
            id: 'l1',
            orderId: 'o1',
            type: LedgerEventType.orderCreated,
            actorId: 'omar',
            at: at,
          ),
          teamId: 't1',
          partyIds: [],
        ),
      ]);

      await db.ordersDao.deleteTeamOrders('t1');
      await db.debtsDao.deleteTeamDebts('t1');
      await db.paymentsDao.deleteTeamPayments('t1');
      await db.ledgerDao.deleteTeamEntries('t1');

      expect(await db.ordersDao.findOrder('o1'), isNull);
      expect(await db.debtsDao.findDebt('d1'), isNull);
      expect(await db.paymentsDao.findPayment('p1'), isNull);
      expect(await db.ledgerDao.watchOrderTimeline('o1').first, isEmpty);
    },
  );
}
