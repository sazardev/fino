import '../../../../core/sync/pull/scoped_collection_applier.dart';
import '../../../../core/sync/remote_document.dart';
import '../mappers/ledger_entry_mapper.dart';
import '../remote/ledger_entry_remote_mapper.dart';

/// `teams/{team}/ledger` → Drift.
///
/// Se escucha con dos consultas que se solapan (las líneas abiertas y las
/// confidenciales de las que soy parte), así que no purga en la inicial: la
/// bitácora solo crece.
class LedgerApplier extends ScopedCollectionApplier {
  const new(super.db, this.teamId);

  final String teamId;

  @override
  bool get purgesOnInitial => false;

  @override
  Future<void> upsert(RemoteDocument document) async {
    final fields = document.fields;
    await db.ledgerDao.insertEntries([
      LedgerEntryMapper.toCompanion(
        LedgerEntryRemoteMapper.fromFields(document.id, fields),
        teamId: teamId,
        partyIds: (fields['partyIds'] as List<Object?>?)?.cast<String>() ?? [],
      ),
    ]);
  }

  @override
  Future<void> delete(String id) => db.ledgerDao.deleteEntry(id);

  @override
  Future<Set<String>> localIds() async => const {};

  @override
  String pathOf(String id) =>
      '${LedgerEntryRemoteMapper.collection(teamId)}/$id';
}
