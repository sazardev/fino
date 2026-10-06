import 'package:fino/core/money/money.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/entities/payout_snapshot.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/review_decision.dart';
import 'package:fino/features/orders/domain/split/split_entry.dart';
import 'package:fino/features/orders/domain/use_cases/add_debtors.dart';
import 'package:fino/features/orders/domain/use_cases/cancel_debt.dart';
import 'package:fino/features/orders/domain/use_cases/cancel_order.dart';
import 'package:fino/features/orders/domain/use_cases/change_order_total.dart';
import 'package:fino/features/orders/domain/use_cases/create_order.dart';
import 'package:fino/features/orders/domain/use_cases/debt_review.dart';
import 'package:fino/features/orders/domain/use_cases/edit_order_details.dart';
import 'package:fino/features/orders/domain/use_cases/find_stale_payments.dart';
import 'package:fino/features/orders/domain/use_cases/object_debt.dart';
import 'package:fino/features/orders/domain/use_cases/redistribute_pending.dart';
import 'package:fino/features/orders/domain/use_cases/report_payment.dart';
import 'package:fino/features/orders/domain/use_cases/retract_payment.dart';
import 'package:fino/features/orders/domain/use_cases/review_debts.dart';
import 'package:fino/features/orders/domain/use_cases/undo_confirmation.dart';
import 'package:fino/features/orders/domain/use_cases/update_debt_amount.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/contract_harness.dart';
import 'support/firestore_rest.dart';
import 'support/rules_emulator.dart';
import 'support/rules_matchers.dart';
import 'support/rules_world.dart';

/// Cada acción del dominio, planeada como lo hará la app, debe pasar las
/// reglas reales de Firestore.
void main() {
  if (skipWithoutRulesEmulator()) return;

  late FirestoreRest db;
  late RulesWorld w;
  late ContractHarness h;
  final members = {'omar', 'ana', 'beto', 'cris'};
  final now = DateTime.utc(2026, 10, 6, 12);
  const shown = PayoutSnapshot(bankName: 'BBVA', last4: '5671');

  setUpAll(() => db = FirestoreRest.fromEnvironment());
  setUp(() async {
    w = await RulesWorld.seed(db);
    h = ContractHarness(w);
  });

  /// Café de $300: Ana y Beto a $100 (Omar consumió el resto).
  Future<RestResult> createCafe() {
    final changes = CreateOrder(h.newId)(
      creditorId: 'omar',
      teamId: w.teamId,
      memberIds: members,
      creditorHasPayoutMethod: true,
      concept: 'Café',
      total: const Money(30000),
      spentAt: now,
      creditorIncluded: true,
      entries: [const SplitEntry('ana'), const SplitEntry('beto')],
      now: now,
    );
    return h.pushOrders('omar', changes);
  }

  OrderChangeSet report(String debtor, {List<String>? debtIds}) {
    final mine = h.debts.values
        .where((d) => d.debtorId == debtor && d.status == DebtStatus.pending)
        .where((d) => debtIds == null || debtIds.contains(d.id))
        .toList();
    return ReportPayment(h.newId)(
      actorId: debtor,
      debts: mine,
      shownAmounts: {for (final d in mine) d.id: d.amount},
      orders: h.orders,
      payoutShown: shown,
      now: now,
      reference: 'SPEI-1',
    );
  }

  String debtOf(String debtor) =>
      h.debts.values.firstWhere((d) => d.debtorId == debtor).id;

  group('creating', () {
    test('an order with its debts, ledger, inbox and access markers', () async {
      expect(await createCafe(), isAllowed);

      expect(await w.read('ana', w.path('debts/${debtOf('ana')}')), isAllowed);
      // M4: el marcador le abre a Ana el método de cobro de Omar.
      expect(
        await w.read('ana', w.path('members/omar/payout/main')),
        isAllowed,
      );
    });

    test(
      'a debtor adds a second order and groups the payment (SPEC 6.3)',
      () async {
        await createCafe();
        final sandwich = CreateOrder(h.newId)(
          creditorId: 'omar',
          teamId: w.teamId,
          memberIds: members,
          creditorHasPayoutMethod: true,
          concept: 'Sándwich',
          total: const Money(8500),
          spentAt: now,
          creditorIncluded: false,
          entries: [const SplitEntry('ana')],
          now: now,
        );
        expect(await h.pushOrders('omar', sandwich), isAllowed);

        expect(await h.pushOrders('ana', report('ana')), isAllowed);
        expect(
          h.withStatus(DebtStatus.paymentReported).map((d) => d.debtorId),
          ['ana', 'ana'],
        );
      },
    );
  });

  group('the payment lifecycle', () {
    setUp(createCafe);

    test('the debtor reports, the creditor confirms (6.2)', () async {
      expect(await h.pushOrders('ana', report('ana')), isAllowed);

      final reviewed = ReviewDebts(h.newId)(
        actorId: 'omar',
        reviews: [
          for (final d in h.withStatus(DebtStatus.paymentReported))
            DebtReview(d, ReviewDecision.confirm),
        ],
        orders: h.orders,
        now: now,
      );
      expect(await h.pushOrders('omar', reviewed), isAllowed);
      expect(h.debts[debtOf('ana')]!.status, DebtStatus.confirmed);
    });

    test(
      'closing the last live debt withdraws access to the payout method',
      () async {
        await h.pushOrders('ana', report('ana'));
        final confirm = ReviewDebts(h.newId)(
          actorId: 'omar',
          reviews: [
            for (final d in h.withStatus(DebtStatus.paymentReported))
              DebtReview(d, ReviewDecision.confirm),
          ],
          orders: h.orders,
          now: now,
        );
        await h.pushOrders('omar', confirm);

        expect(
          await w.read('ana', w.path('members/omar/payout/main')),
          isDenied,
        );
        expect(
          await w.read('beto', w.path('members/omar/payout/main')),
          isAllowed,
        );
      },
    );

    test('the creditor rejects a report: back to pending', () async {
      await h.pushOrders('ana', report('ana'));

      final rejected = ReviewDebts(h.newId)(
        actorId: 'omar',
        reviews: [
          for (final d in h.withStatus(DebtStatus.paymentReported))
            DebtReview(d, ReviewDecision.reject, note: 'no me llegó'),
        ],
        orders: h.orders,
        now: now,
      );

      expect(await h.pushOrders('omar', rejected), isAllowed);
      expect(h.debts[debtOf('ana')]!.paymentId, isNull);
    });

    test('the debtor retracts a report', () async {
      await h.pushOrders('ana', report('ana'));
      final payment = h.payments.values.single;

      final retracted = RetractPayment(h.newId)(
        actorId: 'ana',
        payment: payment,
        debts: h.withStatus(DebtStatus.paymentReported),
        orders: h.orders,
        now: now,
      );

      expect(await h.pushOrders('ana', retracted), isAllowed);
    });

    test('the creditor undoes a confirmation (D4)', () async {
      await h.pushOrders('ana', report('ana'));
      await h.pushOrders(
        'omar',
        ReviewDebts(h.newId)(
          actorId: 'omar',
          reviews: [
            for (final d in h.withStatus(DebtStatus.paymentReported))
              DebtReview(d, ReviewDecision.confirm),
          ],
          orders: h.orders,
          now: now,
        ),
      );
      final confirmed = h.debts[debtOf('ana')]!;

      final undone = UndoConfirmation(h.newId)(
        actorId: 'omar',
        debt: confirmed,
        order: h.orders.values.single,
        debtorIsMember: true,
        now: now,
      );

      expect(await h.pushOrders('omar', undone), isAllowed);
      expect(h.debts[confirmed.id]!.status, DebtStatus.paymentReported);
    });

    test('the debtor objects to a debt (confidential ledger line)', () async {
      final objection = ObjectDebt(h.newId)(
        actorId: 'ana',
        debt: h.debts[debtOf('ana')]!,
        order: h.orders.values.single,
        comment: 'yo no fui',
        now: now,
      );

      expect(await h.pushOrders('ana', objection), isAllowed);
    });

    test('the 48h reminder flag is written by the creditor', () async {
      await h.pushOrders('ana', report('ana'));

      final stale = const FindStalePayments()(
        payments: h.payments.values.toList(),
        debts: h.debts.values.toList(),
        now: now.add(const Duration(hours: 49)),
      );

      expect(stale.payments, isNotEmpty);
      expect(await h.pushOrders('omar', stale), isAllowed);
    });
  });

  group('the creditor edits the order', () {
    setUp(createCafe);

    test('cancels one debt, then the rest of the order', () async {
      final order = h.orders.values.single;
      final cancel = CancelDebt(h.newId)(
        actorId: 'omar',
        debt: h.debts[debtOf('ana')]!,
        order: order,
        note: 'perdonada',
        now: now,
      );
      expect(await h.pushOrders('omar', cancel), isAllowed);

      final rest = CancelOrder(h.newId)(
        actorId: 'omar',
        order: order,
        debts: h.debtsOf(order.id),
        now: now,
      );
      expect(await h.pushOrders('omar', rest), isAllowed);
      expect(
        h.debts.values.map((d) => d.status),
        everyElement(DebtStatus.cancelled),
      );
    });

    test('changes an amount, the details and the total', () async {
      final order = h.orders.values.single;
      final amount = UpdateDebtAmount(h.newId)(
        actorId: 'omar',
        order: order,
        debt: h.debts[debtOf('ana')]!,
        siblings: h.debtsOf(order.id),
        newAmount: const Money(4000),
        now: now,
      );
      expect(await h.pushOrders('omar', amount), isAllowed);

      final details = EditOrderDetails(h.newId)(
        actorId: 'omar',
        order: order,
        concept: 'Café y pan',
        note: 'con leche',
        spentAt: now,
        now: now,
      );
      expect(await h.pushOrders('omar', details), isAllowed);

      final total = ChangeOrderTotal(h.newId)(
        actorId: 'omar',
        order: h.orders[order.id]!,
        debts: h.debtsOf(order.id),
        newTotal: const Money(50000),
        now: now,
      );
      expect(await h.pushOrders('omar', total), isAllowed);
    });

    test('removing the note deletes the field', () async {
      final order = h.orders.values.single;
      await h.pushOrders(
        'omar',
        EditOrderDetails(h.newId)(
          actorId: 'omar',
          order: order,
          concept: 'Café',
          note: 'algo',
          spentAt: now,
          now: now,
        ),
      );

      final cleared = EditOrderDetails(h.newId)(
        actorId: 'omar',
        order: h.orders[order.id]!,
        concept: 'Café',
        spentAt: now,
        now: now,
      );

      expect(await h.pushOrders('omar', cleared), isAllowed);
    });

    test('adds a debtor to an open order', () async {
      final order = h.orders.values.single;

      final added = AddDebtors(h.newId)(
        actorId: 'omar',
        order: order,
        debts: h.debtsOf(order.id),
        memberIds: members,
        newDebtors: {'cris': const Money(5000)},
        now: now,
      );

      expect(await h.pushOrders('omar', added), isAllowed);
      expect(
        await w.read('cris', w.path('members/omar/payout/main')),
        isAllowed,
      );
    });

    test('re-splits what is pending (Re-repartir)', () async {
      final order = h.orders.values.single;

      final redistributed = RedistributePending(h.newId)(
        actorId: 'omar',
        order: order,
        debts: h.debtsOf(order.id),
        creditorIncluded: false,
        entries: [
          const SplitEntry('ana', fixedAmount: Money(20000)),
          const SplitEntry('beto'),
        ],
        now: now,
      );

      expect(await h.pushOrders('omar', redistributed), isAllowed);
      expect(h.debts[debtOf('ana')]!.amount, const Money(20000));
    });
  });
}
