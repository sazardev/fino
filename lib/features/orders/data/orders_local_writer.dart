import '../../../core/database/app_database.dart';
import '../domain/entities/debt.dart';
import '../domain/entities/order_change_set.dart';
import 'mappers/debt_mapper.dart';
import 'mappers/ledger_entry_mapper.dart';
import 'mappers/order_mapper.dart';
import 'mappers/payment_mapper.dart';

/// Guarda en Drift lo que cambió una acción de pedidos.
class OrdersLocalWriter {
  const new(this._db);

  final AppDatabase _db;

  /// [debtsById] resuelve acreedor y deudor de las líneas de bitácora (los
  /// únicos que ven las líneas confidenciales).
  Future<void> write(
    OrderChangeSet changes, {
    required String teamId,
    required Map<String, Debt> debtsById,
  }) async {
    final order = changes.order;
    if (order != null) {
      await _db.ordersDao.upsertOrder(OrderMapper.toCompanion(order));
    }
    await _db.debtsDao.upsertDebts(changes.debts.map(DebtMapper.toCompanion));
    await _db.paymentsDao.upsertPayments(
      changes.payments.map(PaymentMapper.toCompanion),
    );
    await _db.ledgerDao.insertEntries([
      for (final entry in changes.ledger)
        LedgerEntryMapper.toCompanion(
          entry,
          teamId: teamId,
          partyIds: _parties(debtsById[entry.debtId]),
        ),
    ]);
  }

  List<String> _parties(Debt? debt) =>
      debt == null ? const [] : [debt.creditorId, debt.debtorId];
}
