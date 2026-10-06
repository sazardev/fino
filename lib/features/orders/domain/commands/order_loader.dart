import '../entities/debt.dart';
import '../entities/order.dart';
import '../entities/payment.dart';
import '../failures/order_failure.dart';
import '../failures/order_failure_reason.dart';
import '../orders_repository.dart';

/// Carga lo que un comando necesita; si algo no existe, `notFound`.
class OrderLoader {
  const new(this._repo);

  final OrdersRepository _repo;

  Future<Order> order(String orderId) async =>
      await _repo.findOrder(orderId) ?? _missing();

  Future<Debt> debt(String debtId) async => (await debts([debtId])).single;

  /// Las deudas de [debtIds], en ese orden; todas deben existir.
  Future<List<Debt>> debts(Iterable<String> debtIds) async {
    final byId = {
      for (final debt in await _repo.findDebts(debtIds)) debt.id: debt,
    };
    return [for (final id in debtIds) byId[id] ?? _missing()];
  }

  Future<Payment> payment(String paymentId) async =>
      await _repo.findPayment(paymentId) ?? _missing();

  static Never _missing() =>
      throw const OrderFailure(OrderFailureReason.notFound);
}
