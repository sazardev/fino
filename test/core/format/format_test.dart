import 'package:fino/core/format/date_label.dart';
import 'package:fino/core/format/money_format.dart';
import 'package:fino/core/format/money_parser.dart';
import 'package:fino/core/money/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MoneyFormat', () {
    test('pesos with thousands and cents', () {
      expect(MoneyFormat.format(Money.zero), r'$0.00');
      expect(MoneyFormat.format(const Money(5)), r'$0.05');
      expect(MoneyFormat.format(const Money(123456789)), r'$1,234,567.89');
      expect(MoneyFormat.format(const Money(-1200)), r'-$12.00');
      expect(MoneyFormat.signed(const Money(1000)), r'+$10.00');
      expect(MoneyFormat.signed(const Money(-1000)), r'-$10.00');
    });
  });

  group('MoneyParser', () {
    test('accepts what people type', () {
      expect(MoneyParser.parse('300'), const Money(30000));
      expect(MoneyParser.parse(r' $1,234.5 '), const Money(123450));
      expect(MoneyParser.parse('12.05'), const Money(1205));
      expect(MoneyParser.parse('7.'), const Money(700));
    });

    test('rejects what is not an amount', () {
      for (final raw in ['', 'abc', '1.234', '1..2', '-5']) {
        expect(MoneyParser.parse(raw), isNull, reason: raw);
      }
    });

    test('editable text drops needless cents', () {
      expect(MoneyParser.editable(const Money(30000)), '300');
      expect(MoneyParser.editable(const Money(1205)), '12.05');
      expect(MoneyParser.editable(const Money(1250)), '12.50');
    });
  });

  group('DateLabel', () {
    final now = DateTime(2026, 10, 6, 15);

    test('today, yesterday, this year and older', () {
      expect(DateLabel.of(DateTime(2026, 10, 6, 1), now: now), 'Hoy');
      expect(DateLabel.of(DateTime(2026, 10, 5, 23), now: now), 'Ayer');
      expect(DateLabel.of(DateTime(2026, 3, 12), now: now), '12 mar');
      expect(DateLabel.of(DateTime(2025, 12, 2), now: now), '2 dic 2025');
    });

    test('ago is short for the last day, then a date', () {
      expect(DateLabel.ago(now, now: now), 'Ahora');
      expect(
        DateLabel.ago(now.subtract(const Duration(minutes: 5)), now: now),
        'Hace 5 min',
      );
      expect(
        DateLabel.ago(now.subtract(const Duration(hours: 3)), now: now),
        'Hace 3 h',
      );
      expect(
        DateLabel.ago(now.subtract(const Duration(days: 2)), now: now),
        '4 oct',
      );
    });
  });
}
