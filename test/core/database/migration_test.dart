import 'package:drift_dev/api/migrations_native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../generated_migrations/schema.dart';

/// Every schema version in `drift_schemas/` must open and match the code.
void main() {
  late SchemaVerifier verifier;
  const latest = 2;

  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  test('a fresh database matches the latest schema', () async {
    final connection = await verifier.startAt(latest);
    final db = AppDatabase(connection);
    addTearDown(db.close);

    await verifier.migrateAndValidate(db, latest);
  });

  test('v1 upgrades to the latest schema without losing the outbox', () async {
    final schema = await verifier.schemaAt(1);
    schema.rawDatabase.execute(
      'INSERT INTO outbox_entries '
      '(entity, entity_id, operation, payload, attempts, '
      'next_attempt_at, created_at) '
      "VALUES ('debts', 'd1', 'create', '{}', 0, 0, 0)",
    );

    final db = AppDatabase(schema.newConnection());
    addTearDown(db.close);
    await verifier.migrateAndValidate(db, latest);

    final entries = await db.select(db.outboxEntries).get();
    expect(entries.single.entityId, 'd1');
    expect(entries.single.batchId, isEmpty);
  });
}
