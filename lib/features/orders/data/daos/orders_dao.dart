import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../tables/debts.dart';
import '../tables/orders.dart';

part 'orders_dao.g.dart';

/// Consultas locales de pedidos.
@DriftAccessor(tables: [Orders, Debts])
class OrdersDao extends DatabaseAccessor<AppDatabase> with _$OrdersDaoMixin {
  new(super.attachedDatabase);

  Future<void> upsertOrder(OrdersCompanion order) =>
      into(orders).insertOnConflictUpdate(order);

  Future<OrderRow?> findOrder(String orderId) =>
      (select(orders)..where((o) => o.id.equals(orderId))).getSingleOrNull();

  Future<List<OrderRow>> findOrders(Iterable<String> orderIds) =>
      (select(orders)..where((o) => o.id.isIn(orderIds))).get();

  /// Pedidos del equipo, el gasto más reciente primero.
  Stream<List<OrderRow>> watchTeamOrders(String teamId) =>
      (select(orders)
            ..where((o) => o.teamId.equals(teamId))
            ..orderBy([(o) => OrderingTerm.desc(o.spentAt)]))
          .watch();

  /// Pedidos que [userId] registró como acreedor.
  Stream<List<OrderRow>> watchCreatedBy(String userId) =>
      (select(orders)
            ..where((o) => o.creditorId.equals(userId))
            ..orderBy([(o) => OrderingTerm.desc(o.spentAt)]))
          .watch();

  Future<Set<String>> idsOfTeam(String teamId) async => {
    for (final row in await (select(
      orders,
    )..where((o) => o.teamId.equals(teamId))).get())
      row.id,
  };

  Future<void> deleteOrder(String orderId) =>
      (delete(orders)..where((o) => o.id.equals(orderId))).go();

  Future<void> deleteTeamOrders(String teamId) =>
      (delete(orders)..where((o) => o.teamId.equals(teamId))).go();

  /// Pedidos del equipo, cada uno con sus deudas.
  Stream<List<(OrderRow, List<DebtRow>)>> watchTeamOrdersWithDebts(
    String teamId,
  ) => _withDebts(orders.teamId.equals(teamId)).watch().map(_group);

  /// Todos los pedidos guardados (los de mis equipos), con sus deudas.
  Stream<List<(OrderRow, List<DebtRow>)>> watchAllOrdersWithDebts() =>
      _withDebts(const Constant(true)).watch().map(_group);

  /// Un pedido con sus deudas; `null` si no existe.
  Stream<(OrderRow, List<DebtRow>)?> watchOrderWithDebts(String orderId) =>
      _withDebts(orders.id.equals(orderId))
          .watch()
          .map((rows) => _group(rows).firstOrNull);

  JoinedSelectStatement<HasResultSet, dynamic> _withDebts(
    Expression<bool> where,
  ) =>
      select(orders)
          .join([leftOuterJoin(debts, debts.orderId.equalsExp(orders.id))])
        ..where(where)
        ..orderBy([
          OrderingTerm.desc(orders.spentAt),
          OrderingTerm.asc(orders.id),
          OrderingTerm.asc(debts.createdAt),
          OrderingTerm.asc(debts.id),
        ]);

  List<(OrderRow, List<DebtRow>)> _group(List<TypedResult> rows) {
    final byOrder = <String, (OrderRow, List<DebtRow>)>{};
    for (final row in rows) {
      final order = row.readTable(orders);
      final entry = byOrder.putIfAbsent(order.id, () => (order, []));
      final debt = row.readTableOrNull(debts);
      if (debt != null) entry.$2.add(debt);
    }
    return byOrder.values.toList();
  }
}
