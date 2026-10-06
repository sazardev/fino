import '../../../../core/database/outbox_operation.dart';
import '../../../../core/sync/remote_write.dart';
import '../../domain/entities/debt.dart';

/// Mantiene quién puede ver el método de cobro del acreedor (SPEC M4).
///
/// Solo el dueño escribe `members/{él}/payers/{deudor}`: al aparecer una
/// deuda viva con alguien lo da de alta; al cerrarse la última, lo quita.
class PayerMarkerPlanner {
  const new();

  List<RemoteWrite> plan({
    required String actorId,
    required String teamId,
    required List<Debt> changedDebts,
    required Set<String> liveDebtorIdsAfter,
  }) {
    final debtors = {
      for (final debt in changedDebts)
        if (debt.creditorId == actorId) debt.debtorId,
    };
    final collection = 'teams/$teamId/members/$actorId/payers';
    return [
      for (final debtorId in debtors)
        RemoteWrite(
          collection: collection,
          id: debtorId,
          operation: liveDebtorIdsAfter.contains(debtorId)
              ? OutboxOperation.set
              : OutboxOperation.delete,
        ),
    ];
  }
}
