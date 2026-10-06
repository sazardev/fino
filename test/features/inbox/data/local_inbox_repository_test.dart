import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/notifications/intent/notification_intent.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/features/inbox/data/local_inbox_repository.dart';
import 'package:fino/features/inbox/data/mappers/inbox_notification_mapper.dart';
import 'package:fino/features/inbox/domain/entities/inbox_notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late LocalInboxRepository repo;
  final at = DateTime.utc(2026, 10, 6, 12);
  var n = 0;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = LocalInboxRepository(db, () => 'b${++n}', () => at);
    for (final (id, to) in [('n1', 'ana'), ('n2', 'ana'), ('n3', 'beto')]) {
      await db.inboxDao.upsert(
        InboxNotificationMapper.toCompanion(
          InboxNotification(
            id: id,
            createdAt: at,
            intent: NotificationIntent(
              kind: NotificationKind.orderDebtCreated,
              recipientId: to,
              actorId: 'omar',
              teamId: 't1',
              target: const NotificationTarget.debt('d1'),
            ),
          ),
        ),
      );
    }
  });
  tearDown(() => db.close());

  test('watches my notifications and the unread count', () async {
    expect((await repo.watch('ana').first).map((n) => n.id).toSet(), {
      'n1',
      'n2',
    });
    expect(await repo.watchUnreadCount('ana').first, 2);
  });

  test(
    'marking one read updates locally and queues the readAt update',
    () async {
      await repo.markRead('ana', 'n1');

      expect(await repo.watchUnreadCount('ana').first, 1);
      final entry = (await db.select(db.outboxEntries).get()).single;
      expect(entry.entity, 'users/ana/inbox');
      expect(entry.entityId, 'n1');
      expect(entry.operation, OutboxOperation.update);
      expect((await db.outboxDao.writesOfBatch(entry.batchId)).single.fields, {
        'readAt': RemoteMarker.serverTimestamp,
      });
    },
  );

  test(
    'already read, foreign or missing notifications queue nothing',
    () async {
      await repo.markRead('ana', 'n1');
      final before = (await db.select(db.outboxEntries).get()).length;

      await repo.markRead('ana', 'n1');
      await repo.markRead('ana', 'n3');
      await repo.markRead('ana', 'ghost');

      expect((await db.select(db.outboxEntries).get()).length, before);
    },
  );

  test('mark all read queues one batch for the unread ones', () async {
    await repo.markAllRead('ana');
    await repo.markAllRead('ana');

    expect(await repo.watchUnreadCount('ana').first, 0);
    expect(await repo.watchUnreadCount('beto').first, 1);
    final entries = await db.select(db.outboxEntries).get();
    expect(entries, hasLength(2));
    expect(entries.map((e) => e.batchId).toSet(), hasLength(1));
  });

  test('removing deletes locally and queues the delete', () async {
    await repo.remove('ana', 'n2');
    await repo.remove('ana', 'n3');

    expect((await repo.watch('ana').first).map((n) => n.id), ['n1']);
    final entry = (await db.select(db.outboxEntries).get()).single;
    expect(entry.operation, OutboxOperation.delete);
    expect(entry.entityId, 'n2');
  });
}
