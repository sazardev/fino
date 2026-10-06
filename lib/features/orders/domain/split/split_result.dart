import '../../../../core/money/money.dart';

/// Resultado de repartir un gasto: lo que debe cada quien y lo que le toca
/// al propio acreedor (que nunca genera deuda).
final class SplitResult {
  const new({required this.amountByDebtor, required this.creditorShare});

  /// Monto por deudor, en el mismo orden que los participantes.
  final Map<String, Money> amountByDebtor;
  final Money creditorShare;
}
