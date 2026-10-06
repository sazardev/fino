import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/entities/order_change_set.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';
import 'package:fino/features/orders/domain/enums/ledger_event_type.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/use_cases/change_order_total.dart';
import 'package:fino/features/orders/domain/use_cases/edit_order_details.dart';
import 'package:fino/features/orders/domain/use_cases/update_debt_amount.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  final order = buildOrder();
  final ana = buildDebt();
  final beto = buildDebt(id: 'd2', debtorId: 'beto');
  final cancelled = buildDebt(
    id: 'd3',
    debtorId: 'cris',
    amount: pesos(150),
    status: DebtStatus.cancelled,
  );

  group('EditOrderDetails', () {
    EditOrderDetails edit() => EditOrderDetails(sequentialIds());

    test('edits concept, note and date without notifying (SPEC 5.5)', () {
      final changes = edit()(
        actorId: 'omar',
        order: order,
        concept: ' Comida ',
        note: 'de la oficina',
        spentAt: t0.add(const Duration(days: 1)),
        now: t0.add(const Duration(days: 2)),
      );

      expect(changes.order!.concept, 'Comida');
      expect(changes.order!.note, 'de la oficina');
      expect(changes.ledger.single.type, LedgerEventType.orderDetailsEdited);
      expect(changes.notifications, isEmpty);
    });

    test('saving without changes is a no-op', () {
      final changes = edit()(
        actorId: 'omar',
        order: order,
        concept: order.concept,
        spentAt: order.spentAt,
        now: t0,
      );

      expect(changes.isEmpty, isTrue);
    });

    test('only the creditor edits and the concept stays valid', () {
      expect(
        () => edit()(
          actorId: 'ana',
          order: order,
          concept: 'x',
          spentAt: t0,
          now: t0,
        ),
        throwsOrder(OrderFailureReason.notCreditor),
      );
      expect(
        () => edit()(
          actorId: 'omar',
          order: order,
          concept: ' ',
          spentAt: t0,
          now: t0,
        ),
        throwsOrder(OrderFailureReason.conceptRequired),
      );
    });
  });

  group('ChangeOrderTotal', () {
    ChangeOrderTotal change() => ChangeOrderTotal(sequentialIds());

    OrderChangeSet Function() total(Money value, {String actor = 'omar'}) =>
        () => change()(
          actorId: actor,
          order: order,
          debts: [ana, beto, cancelled],
          newTotal: value,
          now: t0,
        );

    test('changes the total while it covers the active debts', () {
      final changes = total(pesos(400))();

      expect(changes.order!.total, pesos(400));
      expect(changes.ledger.single.type, LedgerEventType.orderTotalChanged);
      expect(changes.ledger.single.amountBefore, pesos(300));
      expect(changes.ledger.single.amountAfter, pesos(400));
    });

    test('cancelled debts do not count against the new total', () {
      expect(total(pesos(120))().order!.total, pesos(120));
    });

    test('rejects a total below the active debts or not positive', () {
      expect(
        total(pesos(100)),
        throwsOrder(OrderFailureReason.totalBelowDebts),
      );
      expect(
        total(Money.zero),
        throwsOrder(OrderFailureReason.totalNotPositive),
      );
    });

    test('same total is a no-op; only the creditor changes it', () {
      expect(total(pesos(300))().isEmpty, isTrue);
      expect(
        total(pesos(400), actor: 'ana'),
        throwsOrder(OrderFailureReason.notCreditor),
      );
    });
  });

  group('UpdateDebtAmount', () {
    OrderChangeSet Function() update(
      Money amount, {
      Debt? debt,
      String actor = 'omar',
    }) =>
        () => UpdateDebtAmount(sequentialIds())(
          actorId: actor,
          order: order,
          debt: debt ?? ana,
          siblings: [ana, beto, cancelled],
          newAmount: amount,
          now: t0,
        );

    test('lowers a pending debt and warns the debtor (partial payment)', () {
      final changes = update(pesos(40))();

      expect(changes.debts.single.amount, pesos(40));
      expect(changes.ledger.single.amountBefore, pesos(60));
      expect(changes.ledger.single.amountAfter, pesos(40));
      expect(
        changes.notifications.single.kind,
        NotificationKind.debtAmountChanged,
      );
      expect(changes.notifications.single.amount, pesos(40));
    });

    test('same amount is a no-op', () {
      expect(update(pesos(60))().isEmpty, isTrue);
    });

    test('cannot push the debts above the order total', () {
      expect(
        update(pesos(250)),
        throwsOrder(OrderFailureReason.sumExceedsTotal),
      );
    });

    test('rejects amounts that are not positive, frozen debts, strangers', () {
      expect(
        update(Money.zero),
        throwsOrder(OrderFailureReason.amountNotPositive),
      );
      expect(
        update(
          pesos(10),
          debt: ana.copyWith(status: DebtStatus.paymentReported),
        ),
        throwsOrder(OrderFailureReason.invalidTransition),
      );
      expect(
        update(pesos(10), actor: 'ana'),
        throwsOrder(OrderFailureReason.notCreditor),
      );
    });
  });
}
