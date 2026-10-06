import '../entities/debt.dart';
import '../entities/order.dart';

/// Concepto con el que se resume un grupo de deudas en una notificación.
abstract final class DebtConcepts {
  /// Concepto del primer pedido de [debts]; `null` si no se conoce.
  static String? lead(Iterable<Debt> debts, Map<String, Order> orders) {
    for (final debt in debts) {
      final order = orders[debt.orderId];
      if (order != null) return order.concept;
    }
    return null;
  }
}
