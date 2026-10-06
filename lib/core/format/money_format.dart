import '../money/money.dart';

/// Pesos como se leen en México: `$1,234.50`; los negativos `-$12.00`.
abstract final class MoneyFormat {
  static String format(Money money) {
    final negative = money.isNegative;
    final cents = money.cents.abs();
    final pesos = _group('${cents ~/ 100}');
    final decimals = '${cents % 100}'.padLeft(2, '0');
    return '${negative ? '-' : ''}\$$pesos.$decimals';
  }

  /// Con signo explícito: `+$10.00` / `-$10.00` (deuda a favor / en contra).
  static String signed(Money money) =>
      money.isNegative ? format(money) : '+${format(money)}';

  static String _group(String digits) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }
}
