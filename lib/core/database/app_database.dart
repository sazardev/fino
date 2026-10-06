import 'package:drift/drift.dart';

import 'daos/outbox_dao.dart';
import 'outbox_operation.dart';
import 'tables/outbox_entries.dart';

part 'app_database.g.dart';

/// The app's local source of truth. Bump [schemaVersion] with a migration and
/// a schema dump (`drift_schemas/`) on every change.
@DriftDatabase(tables: [OutboxEntries], daos: [OutboxDao])
class AppDatabase extends _$AppDatabase {
  new(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (m) => m.createAll());

  /// Deletes every row of every table (sign-out).
  Future<void> wipe() => transaction(() async {
    for (final table in allTables) {
      await delete(table).go();
    }
  });
}
