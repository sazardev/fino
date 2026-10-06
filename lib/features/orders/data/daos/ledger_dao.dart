import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../tables/ledger_entries.dart';

part 'ledger_dao.g.dart';

/// Consultas locales de la bitácora (solo se agrega, nunca se edita).
@DriftAccessor(tables: [LedgerEntries])
class LedgerDao extends DatabaseAccessor<AppDatabase> with _$LedgerDaoMixin {
  new(super.attachedDatabase);

  Future<void> insertEntries(Iterable<LedgerEntriesCompanion> rows) =>
      batch((b) => b.insertAllOnConflictUpdate(ledgerEntries, rows.toList()));

  Stream<List<LedgerRow>> watchOrderTimeline(String orderId) =>
      (select(ledgerEntries)
            ..where((e) => e.orderId.equals(orderId))
            ..orderBy([(e) => OrderingTerm.asc(e.at)]))
          .watch();

  Future<void> deleteEntry(String entryId) =>
      (delete(ledgerEntries)..where((e) => e.id.equals(entryId))).go();

  Future<void> deleteTeamEntries(String teamId) =>
      (delete(ledgerEntries)..where((e) => e.teamId.equals(teamId))).go();
}
