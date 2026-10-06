import '../../../core/database/app_database.dart';
import '../../../core/ids/id_generator.dart';
import '../../../core/time/clock.dart';
import '../domain/entities/debt.dart';
import '../domain/entities/ledger_entry.dart';
import '../domain/entities/order.dart';
import '../domain/entities/order_change_set.dart';
import '../domain/entities/payment.dart';
import '../domain/orders_repository.dart';
import '../domain/views/order_summary.dart';
import 'mappers/debt_mapper.dart';
import 'mappers/ledger_entry_mapper.dart';
import 'mappers/order_mapper.dart';
import 'mappers/payment_mapper.dart';
import 'order_change_recorder.dart';

/// Pedidos leídos de Drift (la fuente de verdad de la UI). Cada acción se
/// guarda primero ahí y deja su lote listo en el outbox.
class LocalOrdersRepository implements OrdersRepository {
  new(this._db, IdGenerator newId, Clock clock)
    : _recorder = OrderChangeRecorder(_db, newId, clock);

  final AppDatabase _db;
  final OrderChangeRecorder _recorder;

  @override
  Stream<List<OrderSummary>> watchTeamOrders(String teamId) => _db.ordersDao
      .watchTeamOrdersWithDebts(teamId)
      .map((rows) => rows.map(_summary).toList());

  @override
  Stream<List<OrderSummary>> watchAllOrders() => _db.ordersDao
      .watchAllOrdersWithDebts()
      .map((rows) => rows.map(_summary).toList());

  @override
  Stream<List<Debt>> watchDebtsOfPayment(String paymentId) =>
      _db.debtsDao.watchDebtsOfPayment(paymentId).map(_debts);

  @override
  Stream<OrderSummary?> watchOrder(String orderId) => _db.ordersDao
      .watchOrderWithDebts(orderId)
      .map((row) => row == null ? null : _summary(row));

  @override
  Stream<List<Debt>> watchLiveDebtsOf(String userId) =>
      _db.debtsDao.watchLiveDebtsOf(userId).map(_debts);

  @override
  Stream<List<Debt>> watchClosedDebtsOf(String userId) =>
      _db.debtsDao.watchClosedDebtsOf(userId).map(_debts);

  @override
  Stream<List<Debt>> watchTeamDebts(String teamId) =>
      _db.debtsDao.watchTeamDebts(teamId).map(_debts);

  @override
  Stream<List<LedgerEntry>> watchTimeline(String orderId, String viewerId) =>
      _db.ledgerDao
          .watchOrderTimeline(orderId)
          .map(
            (rows) => [
              for (final row in rows)
                if (!row.type.confidential || row.partyIds.contains(viewerId))
                  LedgerEntryMapper.toDomain(row),
            ],
          );

  @override
  Future<Order?> findOrder(String orderId) async {
    final row = await _db.ordersDao.findOrder(orderId);
    return row == null ? null : OrderMapper.toDomain(row);
  }

  @override
  Future<Map<String, Order>> findOrders(Iterable<String> orderIds) async => {
    for (final row in await _db.ordersDao.findOrders(orderIds))
      row.id: OrderMapper.toDomain(row),
  };

  @override
  Future<List<Debt>> findDebts(Iterable<String> debtIds) async =>
      _debts(await _db.debtsDao.findDebts(debtIds));

  @override
  Future<List<Debt>> debtsOfOrder(String orderId) async =>
      _debts(await _db.debtsDao.debtsOfOrder(orderId));

  @override
  Future<List<Debt>> debtsOfPayment(String paymentId) async =>
      _debts(await _db.debtsDao.debtsOfPayment(paymentId));

  @override
  Future<Payment?> findPayment(String paymentId) async {
    final row = await _db.paymentsDao.findPayment(paymentId);
    return row == null ? null : PaymentMapper.toDomain(row);
  }

  @override
  Future<List<Payment>> paymentsToRemind(String creditorId) async => [
    for (final row in await _db.paymentsDao.pendingReminders(creditorId))
      PaymentMapper.toDomain(row),
  ];

  @override
  Future<void> apply(
    OrderChangeSet changes, {
    required String actorId,
    required String teamId,
  }) async {
    if (changes.isEmpty) return;
    await _recorder.record(changes, actorId: actorId, teamId: teamId);
  }

  OrderSummary _summary((OrderRow, List<DebtRow>) row) =>
      OrderSummary(OrderMapper.toDomain(row.$1), _debts(row.$2));

  List<Debt> _debts(List<DebtRow> rows) => [
    for (final row in rows) DebtMapper.toDomain(row),
  ];
}
