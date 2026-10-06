import '../../../../core/sync/pull/scoped_collection_applier.dart';
import '../../../../core/sync/remote_document.dart';
import '../mappers/debt_mapper.dart';
import '../remote/debt_remote_mapper.dart';

/// `teams/{team}/debts` → Drift.
class DebtsApplier extends ScopedCollectionApplier {
  const new(super.db, this.teamId);

  final String teamId;

  @override
  Future<void> upsert(RemoteDocument document) => db.debtsDao.upsertDebts([
    DebtMapper.toCompanion(
      DebtRemoteMapper.fromFields(document.id, teamId, document.fields),
    ),
  ]);

  @override
  Future<void> delete(String id) => db.debtsDao.deleteDebt(id);

  @override
  Future<Set<String>> localIds() => db.debtsDao.idsOfTeam(teamId);

  @override
  String pathOf(String id) => '${DebtRemoteMapper.collection(teamId)}/$id';
}
