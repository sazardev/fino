import 'entities/debt.dart';
import 'entities/ledger_entry.dart';
import 'entities/order.dart';
import 'entities/order_change_set.dart';
import 'entities/payment.dart';
import 'views/order_summary.dart';

/// Pedidos, deudas, pagos y bitácora: lo que la UI observa y lo que los
/// comandos necesitan para decidir.
///
/// Es offline-first: todo se lee de la base local y [apply] guarda primero
/// ahí y deja la escritura lista para sincronizarse.
abstract interface class OrdersRepository {
  /// Pedidos del equipo con sus deudas, el gasto más reciente primero.
  Stream<List<OrderSummary>> watchTeamOrders(String teamId);

  /// Todos los pedidos de mis equipos, el gasto más reciente primero.
  Stream<List<OrderSummary>> watchAllOrders();

  Stream<OrderSummary?> watchOrder(String orderId);

  /// Deudas vivas donde [userId] es parte (alimenta Debo / Me deben).
  Stream<List<Debt>> watchLiveDebtsOf(String userId);

  /// Historial: deudas confirmadas o canceladas donde [userId] es parte.
  Stream<List<Debt>> watchClosedDebtsOf(String userId);

  /// Todas las deudas del equipo (vista de equipo, solo lectura).
  Stream<List<Debt>> watchTeamDebts(String teamId);

  /// Línea de tiempo del pedido tal como la ve [viewerId]: las líneas
  /// confidenciales solo las ven acreedor y deudor.
  Stream<List<LedgerEntry>> watchTimeline(String orderId, String viewerId);

  Future<Order?> findOrder(String orderId);

  Future<Map<String, Order>> findOrders(Iterable<String> orderIds);

  Future<List<Debt>> findDebts(Iterable<String> debtIds);

  Future<List<Debt>> debtsOfOrder(String orderId);

  Future<Payment?> findPayment(String paymentId);

  /// Pagos hacia [creditorId] a los que aún no se les avisó (SPEC #13).
  Future<List<Payment>> paymentsToRemind(String creditorId);

  /// Deudas ligadas ahora a un pago (las rechazadas o retiradas ya no).
  Stream<List<Debt>> watchDebtsOfPayment(String paymentId);

  /// Deudas ligadas a un pago.
  Future<List<Debt>> debtsOfPayment(String paymentId);

  /// Guarda el resultado de una acción: filas locales y lote para el
  /// servidor, en una sola transacción. [teamId] es el equipo de la acción.
  Future<void> apply(
    OrderChangeSet changes, {
    required String actorId,
    required String teamId,
  });
}
