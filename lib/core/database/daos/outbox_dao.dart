import 'package:drift/drift.dart';

import '../app_database.dart';
import '../outbox_backoff.dart';
import '../outbox_operation.dart';
import '../tables/outbox_entries.dart';

part 'outbox_dao.g.dart';

/// Queries over the pending-writes queue.
@DriftAccessor(tables: [OutboxEntries])
class OutboxDao extends DatabaseAccessor<AppDatabase> with _$OutboxDaoMixin {
  new(super.attachedDatabase);

  Future<int> enqueue({
    required String entity,
    required String entityId,
    required OutboxOperation operation,
    required DateTime now,
    String payload = '',
  }) => into(outboxEntries).insert(
    OutboxEntriesCompanion.insert(
      entity: entity,
      entityId: entityId,
      operation: operation,
      payload: Value(payload),
      nextAttemptAt: now,
      createdAt: now,
    ),
  );

  Stream<int> watchPendingCount() {
    final count = outboxEntries.id.count();
    return (selectOnly(
      outboxEntries,
    )..addColumns([count])).map((row) => row.read(count) ?? 0).watchSingle();
  }

  /// Entries ready to be sent at [now], oldest first.
  Future<List<OutboxEntry>> due(DateTime now, {int limit = 50}) =>
      (select(outboxEntries)
            ..where((e) => e.nextAttemptAt.isSmallerOrEqualValue(now))
            ..orderBy([(e) => OrderingTerm.asc(e.id)])
            ..limit(limit))
          .get();

  Future<void> markFailed(OutboxEntry entry, {required DateTime now}) {
    final attempts = entry.attempts + 1;
    return (update(outboxEntries)..where((e) => e.id.equals(entry.id))).write(
      OutboxEntriesCompanion(
        attempts: Value(attempts),
        nextAttemptAt: Value(now.add(outboxBackoff(attempts))),
      ),
    );
  }

  Future<void> remove(int id) =>
      (delete(outboxEntries)..where((e) => e.id.equals(id))).go();
}
