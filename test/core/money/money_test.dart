import 'package:fino/core/money/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('arithmetic and comparison work on cents', () {
    const a = Money(1050);
    const b = Money(250);

    expect(a + b, const Money(1300));
    expect(a - b, const Money(800));
    expect(b * 3, const Money(750));
    expect(a > b && a >= b && b < a && b <= a, isTrue);
    expect(a.compareTo(b), greaterThan(0));
  });

  test('sign helpers', () {
    expect(Money.zero.isZero, isTrue);
    expect(const Money(1).isPositive, isTrue);
    expect(const Money(-1).isNegative, isTrue);
  });

  test('sum of nothing is zero', () {
    expect(Money.sum(const []), Money.zero);
    expect(Money.sum(const [Money(100), Money(250)]), const Money(350));
  });

  test('equality and toString', () {
    expect(const Money(5), const Money(5));
    expect(const Money(5).hashCode, const Money(5).hashCode);
    expect(const Money(5).toString(), 'Money(5)');
  });
}
