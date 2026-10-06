import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/database/outbox_backoff.dart';
import 'package:fino/core/database/outbox_operation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  final now = DateTime.utc(2026, 1, 1, 12);

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<int> enqueue(String id) => db.outboxDao.enqueue(
    entity: 'debts',
    entityId: id,
    operation: OutboxOperation.create,
    payload: '{}',
    now: now,
  );

  test('due returns entries ready now, oldest first', () async {
    await enqueue('a');
    await enqueue('b');

    final due = await db.outboxDao.due(now);

    expect(due.map((e) => e.entityId), ['a', 'b']);
  });

  test('a failed entry waits out its backoff', () async {
    await enqueue('a');
    final entry = (await db.outboxDao.due(now)).single;

    await db.outboxDao.markFailed(entry, now: now);

    expect(await db.outboxDao.due(now), isEmpty);
    final later = now.add(outboxBackoff(1));
    final retry = (await db.outboxDao.due(later)).single;
    expect(retry.attempts, 1);
  });

  test('remove deletes the entry', () async {
    final id = await enqueue('a');
    await db.outboxDao.remove(id);
    expect(await db.outboxDao.due(now), isEmpty);
  });

  test('watchPendingCount follows the queue', () async {
    final counts = db.outboxDao.watchPendingCount();
    final seen = <int>[];
    final subscription = counts.listen(seen.add);
    addTearDown(subscription.cancel);

    await pumpEventQueue();
    await enqueue('a');
    await pumpEventQueue();
    await enqueue('b');
    await pumpEventQueue();

    expect(seen, [0, 1, 2]);
  });

  test('wipe empties every table', () async {
    await enqueue('a');
    await db.wipe();
    expect(await db.outboxDao.due(now.add(const Duration(days: 1))), isEmpty);
  });
}
