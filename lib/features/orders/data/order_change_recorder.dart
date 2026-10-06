import '../../../core/database/app_database.dart';
import '../../../core/ids/id_generator.dart';
import '../../../core/notifications/inbox_write_planner.dart';
import '../../../core/time/clock.dart';
import '../domain/entities/debt.dart';
import '../domain/entities/order_change_set.dart';
import 'mappers/debt_mapper.dart';
import 'orders_local_writer.dart';
import 'remote/order_write_planner.dart';

/// Guarda el resultado de una acción de pedidos: filas locales y el lote del
/// outbox, en una sola transacción.
class OrderChangeRecorder {
  new(this._db, this._newId, this._clock)
    : _writer = OrdersLocalWriter(_db),
      _inbox = InboxWritePlanner(_newId);

  final AppDatabase _db;
  final IdGenerator _newId;
  final Clock _clock;
  final OrdersLocalWriter _writer;
  final InboxWritePlanner _inbox;
  static const _planner = OrderWritePlanner();

  Future<void> record(
    OrderChangeSet changes, {
    required String actorId,
    required String teamId,
  }) => _db.transaction(() async {
    final known = await _known(changes);
    await _writer.write(
      changes,
      teamId: teamId,
      debtsById: await _debtsForLedger(changes),
    );
    final writes = [
      ..._planner.plan(
        changes,
        actorId: actorId,
        teamId: teamId,
        known: known,
        debtsById: await _debtsForLedger(changes),
        liveDebtorIdsAfter: await _db.debtsDao.liveDebtorIdsOfCreditor(
          actorId,
          teamId,
        ),
      ),
      ..._inbox.plan(changes.notifications),
    ];
    await _db.outboxDao.enqueueBatch(writes, batchId: _newId(), now: _clock());
  });

  /// Lo que ya existía antes de guardar: decide crear o actualizar.
  Future<KnownIds> _known(OrderChangeSet changes) async {
    final order = changes.order;
    return KnownIds(
      orders: {
        if (order != null && await _db.ordersDao.findOrder(order.id) != null)
          order.id,
      },
      debts: {
        for (final row in await _db.debtsDao.findDebts(
          changes.debts.map((d) => d.id),
        ))
          row.id,
      },
      payments: {
        for (final row in await _db.paymentsDao.findPayments(
          changes.payments.map((p) => p.id),
        ))
          row.id,
      },
    );
  }

  /// Deudas que resuelven acreedor y deudor de las líneas de bitácora.
  Future<Map<String, Debt>> _debtsForLedger(OrderChangeSet changes) async => {
    for (final row in await _db.debtsDao.findDebts({
      for (final e in changes.ledger)
        if (e.debtId != null) e.debtId!,
    }))
      row.id: DebtMapper.toDomain(row),
    for (final debt in changes.debts) debt.id: debt,
  };
}
