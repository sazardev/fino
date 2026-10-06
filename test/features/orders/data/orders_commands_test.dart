import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/features/orders/domain/commands/debt_decision.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/order_status.dart';
import 'package:fino/features/orders/domain/enums/review_decision.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/split/split_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../domain/support/order_fixtures.dart';
import 'support/orders_harness.dart';

void main() {
  late OrdersHarness h;

  setUp(() async => h = await OrdersHarness.create());
  tearDown(() => h.close());

  /// Café de $300 con Ana y Beto (omar consumió su parte).
  Future<List<Debt>> createCafe() async {
    await h.createOrder(
      actorId: 'omar',
      teamId: 't1',
      concept: 'Café',
      total: const Money(30000),
      spentAt: h.now(),
      creditorIncluded: true,
      entries: [const SplitEntry('ana'), const SplitEntry('beto')],
    );
    final debts = await h.repo.watchLiveDebtsOf('omar').first;
    return debts;
  }

  Future<String> reportAnasPayment() async {
    final debt = (await h.repo.watchLiveDebtsOf('ana').first).single;
    final payment = await h.reportPayment(
      actorId: 'ana',
      debtIds: [debt.id],
      shownAmounts: {debt.id: debt.amount},
      reference: 'SPEI-1',
    );
    return payment.id;
  }

  group('creating an order', () {
    test('saves rows locally and queues ONE atomic batch', () async {
      final debts = await createCafe();

      expect(debts.map((d) => d.debtorId), ['ana', 'beto']);
      expect(debts.map((d) => d.amount), everyElement(const Money(10000)));
      final summary = (await h.repo.watchTeamOrders('t1').first).single;
      expect(summary.order.concept, 'Café');
      expect(summary.status, OrderStatus.open);
      expect(summary.creditorShare, const Money(10000));

      final batches = await h.batches();
      expect(batches, hasLength(1));
      final paths = batches.single.map((w) => w.path).toList();
      expect(paths.where((p) => p.contains('/orders/')), hasLength(1));
      expect(paths.where((p) => p.contains('/debts/')), hasLength(2));
      expect(paths.where((p) => p.contains('/ledger/')), hasLength(3));
      expect(paths.where((p) => p.contains('/payers/')), hasLength(2));
      expect(paths.where((p) => p.startsWith('users/')), hasLength(2));
    });

    test('needs a payout method (M2) and team members', () async {
      final noPayout = await OrdersHarness.create(omarHasPayout: false);
      addTearDown(noPayout.close);

      expect(
        () => noPayout.createOrder(
          actorId: 'omar',
          teamId: 't1',
          concept: 'Café',
          total: const Money(30000),
          spentAt: noPayout.now(),
          creditorIncluded: true,
          entries: [const SplitEntry('ana')],
        ),
        throwsOrder(OrderFailureReason.creditorWithoutPayoutMethod),
      );
      expect(await noPayout.batches(), isEmpty);
    });
  });

  group('the payment lifecycle', () {
    test(
      'report → confirm closes the debt and drops the access marker',
      () async {
        await createCafe();
        final paymentId = await reportAnasPayment();

        final ana = await h.repo.debtsOfPayment(paymentId);
        expect(ana.single.status, DebtStatus.paymentReported);
        final payment = (await h.repo.findPayment(paymentId))!;
        expect(payment.payoutShown.last4, '5671');
        expect(payment.reference, 'SPEI-1');

        await h.reviewDebts(
          actorId: 'omar',
          decisions: [
            (
              debtId: ana.single.id,
              decision: ReviewDecision.confirm,
              note: null,
            ),
          ],
        );

        expect(
          (await h.repo.findDebts([ana.single.id])).single.status,
          DebtStatus.confirmed,
        );
        final last = (await h.batches()).last;
        final marker = last.firstWhere((w) => w.collection.endsWith('payers'));
        expect(marker.id, 'ana');
        expect(marker.operation, OutboxOperation.delete);
      },
    );

    test('a debtor with other live debts keeps the marker', () async {
      await createCafe();
      await h.createOrder(
        actorId: 'omar',
        teamId: 't1',
        concept: 'Pan',
        total: const Money(5000),
        spentAt: h.now(),
        creditorIncluded: false,
        entries: [const SplitEntry('ana')],
      );
      final cafeDebt = (await h.repo.watchLiveDebtsOf('ana').first).first;
      final payment = await h.reportPayment(
        actorId: 'ana',
        debtIds: [cafeDebt.id],
        shownAmounts: {cafeDebt.id: cafeDebt.amount},
      );
      await h.reviewDebts(
        actorId: 'omar',
        decisions: [
          (debtId: cafeDebt.id, decision: ReviewDecision.confirm, note: null),
        ],
      );

      expect(payment.debtIds, [cafeDebt.id]);
      final marker = (await h.batches()).last.firstWhere(
        (w) => w.collection.endsWith('payers'),
      );
      expect(marker.operation, OutboxOperation.set);
    });

    test('reject, retract and undo return debts to the right state', () async {
      await createCafe();
      final paymentId = await reportAnasPayment();
      final debtId = (await h.repo.debtsOfPayment(paymentId)).single.id;

      await h.retractPayment(actorId: 'ana', paymentId: paymentId);
      expect(
        (await h.repo.findDebts([debtId])).single.status,
        DebtStatus.pending,
      );

      final again = await h.reportPayment(
        actorId: 'ana',
        debtIds: [debtId],
        shownAmounts: {debtId: const Money(10000)},
      );
      await h.reviewDebts(
        actorId: 'omar',
        decisions: [
          (debtId: debtId, decision: ReviewDecision.reject, note: 'no llegó'),
        ],
      );
      expect((await h.repo.findDebts([debtId])).single.paymentId, isNull);

      await h.reportPayment(
        actorId: 'ana',
        debtIds: [debtId],
        shownAmounts: {debtId: const Money(10000)},
      );
      await h.reviewDebts(
        actorId: 'omar',
        decisions: [
          (debtId: debtId, decision: ReviewDecision.confirm, note: null),
        ],
      );
      await h.undoConfirmation(actorId: 'omar', debtId: debtId);

      expect(again.id, isNot(paymentId));
      expect(
        (await h.repo.findDebts([debtId])).single.status,
        DebtStatus.paymentReported,
      );
    });

    test(
      'a debtor cannot report to a creditor whose payout is hidden',
      () async {
        await createCafe();
        await h.db.delete(h.db.payoutMethods).go();
        final debt = (await h.repo.watchLiveDebtsOf('ana').first).single;

        expect(
          () => h.reportPayment(
            actorId: 'ana',
            debtIds: [debt.id],
            shownAmounts: {debt.id: debt.amount},
          ),
          throwsOrder(OrderFailureReason.creditorWithoutPayoutMethod),
        );
      },
    );
  });

  group('editing', () {
    test('amount, details, total, redistribute and add debtors', () async {
      final debts = await createCafe();
      final order = (await h.repo.watchTeamOrders('t1').first).single.order;
      final ana = debts.firstWhere((d) => d.debtorId == 'ana');

      await h.updateAmount(
        actorId: 'omar',
        debtId: ana.id,
        newAmount: const Money(8000),
      );
      await h.editDetails(
        actorId: 'omar',
        orderId: order.id,
        concept: 'Café y pan',
        spentAt: h.now(),
        note: 'oficina',
      );
      await h.changeTotal(
        actorId: 'omar',
        orderId: order.id,
        newTotal: const Money(40000),
      );
      await h.addDebtors(
        actorId: 'omar',
        orderId: order.id,
        newDebtors: {'cris': const Money(5000)},
      );
      await h.redistribute(
        actorId: 'omar',
        orderId: order.id,
        creditorIncluded: false,
        entries: [
          const SplitEntry('ana', fixedAmount: Money(20000)),
          const SplitEntry('beto'),
          const SplitEntry('cris'),
        ],
      );

      final summary = (await h.repo.watchOrder(order.id).first)!;
      expect(summary.order.concept, 'Café y pan');
      expect(summary.order.total, const Money(40000));
      final byDebtor = {for (final d in summary.debts) d.debtorId: d.amount};
      expect(byDebtor['ana'], const Money(20000));
      expect(byDebtor['beto'], const Money(10000));
      expect(byDebtor['cris'], const Money(10000));
      expect((await h.batches()).length, 6);
    });

    test('cancel a debt, object to one, then cancel the order', () async {
      final debts = await createCafe();
      final order = (await h.repo.watchTeamOrders('t1').first).single.order;
      final ana = debts.firstWhere((d) => d.debtorId == 'ana');
      final beto = debts.firstWhere((d) => d.debtorId == 'beto');

      await h.objectDebt(
        actorId: 'beto',
        debtId: beto.id,
        comment: 'yo no fui',
      );
      await h.cancelDebt(actorId: 'omar', debtId: ana.id, note: 'perdonada');
      await h.cancelOrder(actorId: 'omar', orderId: order.id);

      final summary = (await h.repo.watchOrder(order.id).first)!;
      expect(summary.status, OrderStatus.cancelled);
    });

    test('a missing debt or order is not found', () async {
      expect(
        () => h.cancelDebt(actorId: 'omar', debtId: 'ghost'),
        throwsOrder(OrderFailureReason.notFound),
      );
      expect(
        () => h.cancelOrder(actorId: 'omar', orderId: 'ghost'),
        throwsOrder(OrderFailureReason.notFound),
      );
    });

    test('a repeated action queues nothing', () async {
      final debts = await createCafe();
      final ana = debts.firstWhere((d) => d.debtorId == 'ana');
      await h.cancelDebt(actorId: 'omar', debtId: ana.id);
      final before = (await h.batches()).length;

      await h.cancelDebt(actorId: 'omar', debtId: ana.id);

      expect((await h.batches()).length, before);
    });
  });

  group('the 48 h reminder', () {
    test('warns the creditor once and flags the payment', () async {
      var clock = DateTime.utc(2026, 10, 6, 12);
      final late = await OrdersHarness.create(clock: () => clock);
      addTearDown(late.close);
      await late.createOrder(
        actorId: 'omar',
        teamId: 't1',
        concept: 'Café',
        total: const Money(30000),
        spentAt: clock,
        creditorIncluded: true,
        entries: [const SplitEntry('ana')],
      );
      final debt = (await late.repo.watchLiveDebtsOf('ana').first).single;
      final payment = await late.reportPayment(
        actorId: 'ana',
        debtIds: [debt.id],
        shownAmounts: {debt.id: debt.amount},
      );

      clock = clock.add(const Duration(hours: 49));
      await late.remindStale(creditorId: 'omar');
      await late.remindStale(creditorId: 'omar');

      expect(
        (await late.repo.findPayment(payment.id))!
            .awaitingConfirmationReminderSent,
        isTrue,
      );
      final reminders = [
        for (final batch in await late.batches())
          for (final w in batch)
            if (w.collection.endsWith('/payments') &&
                w.operation == OutboxOperation.update)
              w,
      ];
      expect(reminders, hasLength(1));
    });
  });

  group('timeline (SPEC 7.1, 11)', () {
    test('confidential lines are only for the two parties', () async {
      final debts = await createCafe();
      final order = (await h.repo.watchTeamOrders('t1').first).single.order;
      final beto = debts.firstWhere((d) => d.debtorId == 'beto');
      await h.objectDebt(
        actorId: 'beto',
        debtId: beto.id,
        comment: 'yo no fui',
      );

      final forBeto = await h.repo.watchTimeline(order.id, 'beto').first;
      final forAna = await h.repo.watchTimeline(order.id, 'ana').first;

      expect(forBeto.where((e) => e.note == 'yo no fui'), hasLength(1));
      expect(forAna.where((e) => e.note == 'yo no fui'), isEmpty);
    });
  });

  group('history', () {
    test('closed debts leave the live list and show in history', () async {
      await createCafe();
      final paymentId = await reportAnasPayment();
      final debtId = (await h.repo.debtsOfPayment(paymentId)).single.id;
      await h.reviewDebts(
        actorId: 'omar',
        decisions: <DebtDecision>[
          (debtId: debtId, decision: ReviewDecision.confirm, note: null),
        ],
      );

      expect(await h.repo.watchLiveDebtsOf('ana').first, isEmpty);
      expect((await h.repo.watchClosedDebtsOf('ana').first).single.id, debtId);
      expect(await h.repo.watchTeamDebts('t1').first, hasLength(2));
      expect(h.repo.watchOrder('ghost'), emits(isNull));
    });
  });

  test('batches are made of RemoteWrites', () async {
    await createCafe();

    expect((await h.batches()).single, everyElement(isA<RemoteWrite>()));
  });
}
