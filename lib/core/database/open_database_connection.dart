import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Opens the on-disk database: a background isolate on Android, SQLite/WASM
/// in a worker on the web.
QueryExecutor openDatabaseConnection() => driftDatabase(
  name: 'fino',
  web: DriftWebOptions(
    sqlite3Wasm: Uri.parse('sqlite3.wasm'),
    driftWorker: Uri.parse('drift_worker.js'),
  ),
);
