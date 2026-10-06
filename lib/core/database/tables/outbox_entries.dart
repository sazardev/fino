import 'package:drift/drift.dart';

import '../outbox_operation.dart';

/// Local writes waiting to reach Firestore, oldest first.
@DataClassName('OutboxEntry')
@TableIndex(name: 'outbox_next_attempt', columns: {#nextAttemptAt})
class OutboxEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Collection the entry belongs to.
  TextColumn get entity => text()();

  TextColumn get entityId => text()();

  /// Entradas con el mismo [batchId] viajan en UN solo lote atómico de
  /// Firestore: las reglas validan unas escrituras contra otras (`getAfter`).
  /// Vacío = entrada suelta.
  TextColumn get batchId => text().withDefault(const Constant(''))();

  TextColumn get operation => textEnum<OutboxOperation>()();

  /// JSON body to send; empty for deletes.
  TextColumn get payload => text().withDefault(const Constant(''))();

  IntColumn get attempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextAttemptAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}
