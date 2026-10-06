import 'package:drift_dev/api/migrations_native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../generated_migrations/schema.dart';

/// Every schema version in `drift_schemas/` must open and match the code.
void main() {
  late SchemaVerifier verifier;

  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  test('a fresh database matches the latest schema', () async {
    final connection = await verifier.startAt(1);
    final db = AppDatabase(connection);
    addTearDown(db.close);

    await verifier.migrateAndValidate(db, 1);
  });
}
