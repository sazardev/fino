import '../../../../core/database/outbox_operation.dart';
import '../../../../core/sync/remote_write.dart';
import '../../domain/entities/debt.dart';
import '../../domain/entities/order_change_set.dart';
import 'debt_remote_mapper.dart';
import 'ledger_entry_remote_mapper.dart';
import 'order_remote_mapper.dart';
import 'payer_marker_planner.dart';
import 'payment_remote_mapper.dart';

/// Lo que ya existe en el servidor/local antes de aplicar una acción: decide
/// si cada documento se crea o se actualiza.
final class KnownIds {
  const new({
    this.orders = const {},
    this.debts = const {},
    this.payments = const {},
  });

  final Set<String> orders;
  final Set<String> debts;
  final Set<String> payments;
}

/// Traduce el resultado de una acción de pedidos en las escrituras de UN
/// lote de Firestore (las reglas validan unas contra otras con `getAfter`).
class OrderWritePlanner {
  const new([this._markers = const PayerMarkerPlanner()]);

  final PayerMarkerPlanner _markers;

  /// [debtsById] resuelve acreedor y deudor de las líneas confidenciales;
  /// [liveDebtorIdsAfter] son los deudores de [actorId] que, tras la acción,
  /// siguen con alguna deuda viva con él (mantiene el acceso M4).
  List<RemoteWrite> plan(
    OrderChangeSet changes, {
    required String actorId,
    required String teamId,
    required KnownIds known,
    Map<String, Debt> debtsById = const {},
    Set<String> liveDebtorIdsAfter = const {},
  }) {
    final order = changes.order;
    return [
      if (order != null)
        _write(
          OrderRemoteMapper.collection(teamId),
          order.id,
          exists: known.orders.contains(order.id),
          create: OrderRemoteMapper.toCreateFields(order),
          update: OrderRemoteMapper.toUpdateFields(order),
        ),
      for (final debt in changes.debts)
        _write(
          DebtRemoteMapper.collection(teamId),
          debt.id,
          exists: known.debts.contains(debt.id),
          create: DebtRemoteMapper.toCreateFields(debt),
          update: DebtRemoteMapper.toUpdateFields(debt),
        ),
      for (final payment in changes.payments)
        _write(
          PaymentRemoteMapper.collection(teamId),
          payment.id,
          exists: known.payments.contains(payment.id),
          create: PaymentRemoteMapper.toCreateFields(payment),
          update: PaymentRemoteMapper.toReminderFields(),
        ),
      for (final entry in changes.ledger)
        RemoteWrite(
          collection: LedgerEntryRemoteMapper.collection(teamId),
          id: entry.id,
          operation: OutboxOperation.create,
          fields: LedgerEntryRemoteMapper.toCreateFields(
            entry,
            partyIds: _parties(debtsById[entry.debtId]),
          ),
        ),
      ..._markers.plan(
        actorId: actorId,
        teamId: teamId,
        changedDebts: changes.debts,
        liveDebtorIdsAfter: liveDebtorIdsAfter,
      ),
    ];
  }

  RemoteWrite _write(
    String collection,
    String id, {
    required bool exists,
    required Map<String, Object?> create,
    required Map<String, Object?> update,
  }) => RemoteWrite(
    collection: collection,
    id: id,
    operation: exists ? OutboxOperation.update : OutboxOperation.create,
    fields: exists ? update : create,
  );

  List<String> _parties(Debt? debt) =>
      debt == null ? const [] : [debt.creditorId, debt.debtorId];
}
