import 'package:fino/core/money/money.dart';
import 'package:fino/features/orders/domain/failures/order_failure_reason.dart';
import 'package:fino/features/orders/domain/split/split_calculator.dart';
import 'package:fino/features/orders/domain/split/split_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/order_fixtures.dart';

void main() {
  const calculator = SplitCalculator();

  SplitEntry free(String id) => SplitEntry(id);
  SplitEntry fixed(String id, int amount) =>
      SplitEntry(id, fixedAmount: pesos(amount));

  test('splits evenly among debtors and the creditor (P3)', () {
    final result = calculator.calculate(
      total: pesos(2000),
      creditorId: 'omar',
      creditorIncluded: true,
      entries: [free('ana'), free('beto'), free('cris'), free('dani')],
    );

    expect(result.amountByDebtor.values, everyElement(pesos(400)));
    expect(result.creditorShare, pesos(400));
  });

  test('a fixed amount is respected and the rest recalculates (SPEC 5.3)', () {
    final result = calculator.calculate(
      total: pesos(2000),
      creditorId: 'omar',
      creditorIncluded: true,
      entries: [fixed('ana', 700), free('beto'), free('cris'), free('dani')],
    );

    expect(result.amountByDebtor['ana'], pesos(700));
    expect(result.amountByDebtor['beto'], pesos(325));
    expect(result.amountByDebtor['dani'], pesos(325));
    expect(result.creditorShare, pesos(325));
  });

  test('the creditor absorbs the rounding cents (P5)', () {
    final result = calculator.calculate(
      total: pesos(100),
      creditorId: 'omar',
      creditorIncluded: true,
      entries: [free('ana'), free('beto')],
    );

    expect(result.amountByDebtor['ana'], const Money(3333));
    expect(result.amountByDebtor['beto'], const Money(3333));
    expect(result.creditorShare, const Money(3334));
  });

  test('without the creditor as participant he keeps only the cents', () {
    final result = calculator.calculate(
      total: pesos(100),
      creditorId: 'omar',
      creditorIncluded: false,
      entries: [free('ana'), free('beto'), free('cris')],
    );

    expect(result.amountByDebtor.values, everyElement(const Money(3333)));
    expect(result.creditorShare, const Money(1));
  });

  test('all fixed: the leftover is the creditor share (P4)', () {
    final result = calculator.calculate(
      total: pesos(300),
      creditorId: 'omar',
      creditorIncluded: false,
      entries: [fixed('ana', 100), fixed('beto', 150)],
    );

    expect(result.amountByDebtor, {'ana': pesos(100), 'beto': pesos(150)});
    expect(result.creditorShare, pesos(50));
  });

  group('rejects', () {
    void Function() call({
      Money? total,
      List<SplitEntry>? entries,
      bool included = true,
    }) =>
        () => calculator.calculate(
          total: total ?? pesos(300),
          creditorId: 'omar',
          creditorIncluded: included,
          entries: entries ?? [free('ana')],
        );

    test('a total that is not positive', () {
      expect(
        call(total: Money.zero),
        throwsOrder(OrderFailureReason.totalNotPositive),
      );
    });

    test('no debtors', () {
      expect(
        call(entries: const []),
        throwsOrder(OrderFailureReason.noDebtors),
      );
    });

    test('a person twice (P6)', () {
      expect(
        call(entries: [free('ana'), free('ana')]),
        throwsOrder(OrderFailureReason.duplicateParticipant),
      );
    });

    test('the creditor as debtor', () {
      expect(
        call(entries: [free('omar')]),
        throwsOrder(OrderFailureReason.creditorCannotOwe),
      );
    });

    test('a fixed amount that is not positive (P1)', () {
      expect(
        call(entries: [fixed('ana', 0)]),
        throwsOrder(OrderFailureReason.amountNotPositive),
      );
    });

    test('fixed amounts above the total (P4)', () {
      expect(
        call(entries: [fixed('ana', 200), fixed('beto', 200)]),
        throwsOrder(OrderFailureReason.fixedExceedsTotal),
      );
    });

    test('a share smaller than one cent', () {
      expect(
        call(total: const Money(1), entries: [free('ana'), free('beto')]),
        throwsOrder(OrderFailureReason.shareTooSmall),
      );
    });
  });

  test('split entries compare by value', () {
    expect(fixed('ana', 1), fixed('ana', 1));
    expect(fixed('ana', 1).hashCode, fixed('ana', 1).hashCode);
    expect(free('ana').isFixed, isFalse);
  });
}
