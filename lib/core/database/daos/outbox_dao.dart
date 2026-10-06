import 'package:drift/drift.dart';

import '../../sync/remote_write.dart';
import '../../sync/remote_write_codec.dart';
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
    String batchId = '',
  }) => into(outboxEntries).insert(
    OutboxEntriesCompanion.insert(
      entity: entity,
      entityId: entityId,
      operation: operation,
      payload: Value(payload),
      batchId: Value(batchId),
      nextAttemptAt: now,
      createdAt: now,
    ),
  );

  /// Encola todas las escrituras de una acción como UN lote atómico.
  Future<void> enqueueBatch(
    Iterable<RemoteWrite> writes, {
    required String batchId,
    required DateTime now,
  }) => transaction(() async {
    for (final write in writes) {
      await enqueue(
        entity: write.collection,
        entityId: write.id,
        operation: write.operation,
        payload: RemoteWriteCodec.encode(write.fields),
        batchId: batchId,
        now: now,
      );
    }
  });

  /// Las escrituras de un lote tal como se encolaron.
  Future<List<RemoteWrite>> writesOfBatch(String batchId) async => [
    for (final entry in await batchOf(batchId))
      RemoteWriteCodec.toWrite(
        entity: entry.entity,
        entityId: entry.entityId,
        operation: entry.operation,
        payload: entry.payload,
      ),
  ];

  /// Las entradas de un mismo lote, en el orden en que se encolaron.
  Future<List<OutboxEntry>> batchOf(String batchId) =>
      (select(outboxEntries)
            ..where((e) => e.batchId.equals(batchId))
            ..orderBy([(e) => OrderingTerm.asc(e.id)]))
          .get();

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

  /// La entrada más antigua, esté o no lista: el outbox es una cola estricta
  /// (una edición no puede llegar antes que la creación que edita).
  Future<OutboxEntry?> head() =>
      (select(outboxEntries)
            ..orderBy([(e) => OrderingTerm.asc(e.id)])
            ..limit(1))
          .getSingleOrNull();

  /// Rutas (`colección/id`) con escrituras pendientes: la sincronización de
  /// bajada no debe pisarlas con lo que el servidor aún no sabe.
  Future<Set<String>> pendingPaths() async => {
    for (final entry in await select(outboxEntries).get())
      '${entry.entity}/${entry.entityId}',
  };

  /// Si algo de [teamId] espera salir (no se debe borrar lo local de ese
  /// equipo aunque el servidor aún no lo conozca).
  Future<bool> hasPendingForTeam(String teamId) async =>
      (await pendingPaths()).any(
        (path) => path.startsWith('teams/$teamId/') || path == 'teams/$teamId',
      );

  Future<void> markBatchFailed(
    Iterable<OutboxEntry> entries, {
    required DateTime now,
  }) => transaction(() async {
    for (final entry in entries) {
      await markFailed(entry, now: now);
    }
  });

  Future<void> removeAll(Iterable<int> ids) =>
      (delete(outboxEntries)..where((e) => e.id.isIn(ids))).go();

  Future<void> remove(int id) =>
      (delete(outboxEntries)..where((e) => e.id.equals(id))).go();
}
