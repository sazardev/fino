import '../money/money.dart';

/// Lo que alguien teclea (`1,234.5`, `$300`, ` 12 `) → [Money]; `null` si no
/// es un monto válido (más de dos decimales, letras, vacío).
abstract final class MoneyParser {
  static final _valid = RegExp(r'^\d+(\.\d{1,2})?$');

  static Money? parse(String raw) {
    final clean = raw.replaceAll(RegExp(r'[\s,$]'), '');
    if (clean.endsWith('.')) return parse(clean.substring(0, clean.length - 1));
    if (!_valid.hasMatch(clean)) return null;
    final parts = clean.split('.');
    final pesos = int.parse(parts.first);
    final cents = parts.length == 1 ? 0 : int.parse(parts[1].padRight(2, '0'));
    return Money(pesos * 100 + cents);
  }

  /// El texto que se pone en un campo para editar [money] (`1234.5`).
  static String editable(Money money) {
    final cents = money.cents;
    if (cents % 100 == 0) return '${cents ~/ 100}';
    return '${cents ~/ 100}.${'${cents % 100}'.padLeft(2, '0')}';
  }
}
