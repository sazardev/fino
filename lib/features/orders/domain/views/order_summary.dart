import '../../../../core/money/money.dart';
import '../entities/debt.dart';
import '../entities/order.dart';
import '../enums/debt_status.dart';
import '../enums/order_status.dart';

/// Un pedido junto con sus deudas, y todo lo que se deriva de ellas.
final class OrderSummary {
  const new(this.order, this.debts);

  final Order order;
  final List<Debt> debts;

  /// Derivado de las deudas (SPEC §5.4).
  OrderStatus get status =>
      OrderStatus.fromDebts(debts.map((debt) => debt.status));

  /// Lo que le toca al propio acreedor: no genera deuda (P3).
  Money get creditorShare =>
      order.total - Money.sum(_active.map((debt) => debt.amount));

  /// Deudas confirmadas sobre deudas no canceladas (ej. "3 de 5").
  ({int confirmed, int total}) get progress => (
    confirmed: debts
        .where((debt) => debt.status == DebtStatus.confirmed)
        .length,
    total: _active.length,
  );

  Iterable<Debt> get _active => debts.where((debt) => debt.status.isActive);
}
