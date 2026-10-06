import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/database/outbox_backoff.dart';
import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/sync/outbox/outbox_processor.dart';
import 'package:fino/core/sync/remote_failure.dart';
import 'package:fino/core/sync/remote_failure_kind.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_remote_gateway.dart';

void main() {
  late AppDatabase db;
  late FakeRemoteGateway gateway;
  late OutboxProcessor processor;
  var now = DateTime.utc(2026, 10, 6, 12);

  setUp(() {
    now = DateTime.utc(2026, 10, 6, 12);
    db = AppDatabase(NativeDatabase.memory());
    gateway = FakeRemoteGateway();
    processor = OutboxProcessor(
      dao: db.outboxDao,
      gateway: gateway,
      clock: () => now,
    );
  });
  tearDown(() => db.close());

  RemoteWrite write(String id, {OutboxOperation op = OutboxOperation.create}) =>
      RemoteWrite(
        collection: 'teams/t1/debts',
        id: id,
        operation: op,
        fields: const {'n': 1},
      );

  Future<void> enqueue(String batch, List<RemoteWrite> writes) =>
      db.outboxDao.enqueueBatch(writes, batchId: batch, now: now);

  test('an empty queue is idle', () async {
    final result = await processor.flush();

    expect(result.committed, 0);
    expect(result.retryAt, isNull);
    expect(gateway.batches, isEmpty);
  });

  test('each batch travels whole, in order, and leaves the queue', () async {
    await enqueue('b1', [write('d1'), write('d2')]);
    await enqueue('b2', [write('d3')]);

    final result = await processor.flush();

    expect(result.committed, 2);
    expect(gateway.batches.map((b) => b.map((w) => w.id).toList()), [
      ['d1', 'd2'],
      ['d3'],
    ]);
    expect(await db.outboxDao.head(), isNull);
  });

  test('a loose entry is its own batch', () async {
    await db.outboxDao.enqueue(
      entity: 'teams/t1/debts',
      entityId: 'd1',
      operation: OutboxOperation.update,
      payload: '{}',
      now: now,
    );

    await processor.flush();

    expect(gateway.batches.single.single.operation, OutboxOperation.update);
  });

  test('a network failure keeps the batch and stops the queue', () async {
    await enqueue('b1', [write('d1')]);
    await enqueue('b2', [write('d2')]);
    gateway.failures.add(const RemoteFailure(RemoteFailureKind.unavailable));

    final result = await processor.flush();

    expect(result.committed, 0);
    expect(gateway.batches, isEmpty);
    expect(result.retryAt, now.add(outboxBackoff(1)));
    final head = (await db.outboxDao.head())!;
    expect(head.attempts, 1);
    expect(head.nextAttemptAt.toUtc(), result.retryAt);
  });

  test('the queue waits for the retry time and then resumes', () async {
    await enqueue('b1', [write('d1')]);
    await enqueue('b2', [write('d2')]);
    gateway.failures.add(const RemoteFailure(RemoteFailureKind.unavailable));
    await processor.flush();

    final early = await processor.flush();
    expect(early.committed, 0);
    expect(early.retryAt, now.add(outboxBackoff(1)));

    now = now.add(outboxBackoff(1));
    final result = await processor.flush();

    expect(result.committed, 2);
    expect(result.retryAt, isNull);
    expect(gateway.batches.map((b) => b.single.id), ['d1', 'd2']);
  });

  test('a rule rejection drops that batch and the queue goes on', () async {
    await enqueue('b1', [write('d1'), write('d2')]);
    await enqueue('b2', [write('d3')]);
    gateway.failures.add(
      const RemoteFailure(RemoteFailureKind.permissionDenied, 'denied'),
    );

    final result = await processor.flush();

    expect(result.committed, 1);
    expect(result.rejections, hasLength(1));
    final rejection = result.rejections.single;
    expect(rejection.batchId, 'b1');
    expect(rejection.paths, ['teams/t1/debts/d1', 'teams/t1/debts/d2']);
    expect(rejection.teamIds, {'t1'});
    expect(rejection.failure.kind, RemoteFailureKind.permissionDenied);
    expect(gateway.batches.single.single.id, 'd3');
    expect(await db.outboxDao.head(), isNull);
  });

  test('rejections of non-team documents name no team', () async {
    await enqueue('b1', [
      const RemoteWrite(
        collection: 'users/u1/inbox',
        id: 'n1',
        operation: OutboxOperation.create,
      ),
    ]);
    gateway.failures.add(
      const RemoteFailure(RemoteFailureKind.permissionDenied),
    );

    final result = await processor.flush();

    expect(result.rejections.single.teamIds, isEmpty);
  });

  test('concurrent flushes share one pass', () async {
    await enqueue('b1', [write('d1')]);

    final results = await Future.wait([processor.flush(), processor.flush()]);

    expect(gateway.batches, hasLength(1));
    expect(identical(results[0], results[1]), isTrue);
  });

  test('pending paths list what the queue still has to send', () async {
    await enqueue('b1', [write('d1'), write('d2')]);

    expect(await db.outboxDao.pendingPaths(), {
      'teams/t1/debts/d1',
      'teams/t1/debts/d2',
    });
  });
}
