import '../../../../core/money/money.dart';
import '../../domain/failures/order_failure_reason.dart';

/// Lo que va quedando del reparto mientras se captura el pedido.
final class DraftSplit {
  const new({
    this.amounts = const {},
    this.creditorShare = Money.zero,
    this.problem,
  });

  /// Monto de cada deudor.
  final Map<String, Money> amounts;

  /// Lo que le toca a quien pagó (no es deuda).
  final Money creditorShare;

  /// Por qué todavía no se puede guardar; `null` si todo cuadra.
  final OrderFailureReason? problem;

  bool get isValid => problem == null && amounts.isNotEmpty;
}
