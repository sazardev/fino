import 'package:drift/native.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/money/money.dart';
import 'package:fino/core/notifications/intent/notification_intent.dart';
import 'package:fino/core/notifications/intent/notification_kind.dart';
import 'package:fino/core/notifications/intent/notification_target.dart';
import 'package:fino/features/inbox/data/mappers/inbox_notification_mapper.dart';
import 'package:fino/features/inbox/domain/entities/inbox_notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  final at = DateTime.utc(2026, 10, 6, 12);

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  InboxNotification note(
    String id, {
    String to = 'ana',
    DateTime? created,
    DateTime? readAt,
    bool full = false,
  }) => InboxNotification(
    id: id,
    createdAt: created ?? at,
    readAt: readAt,
    intent: NotificationIntent(
      kind: NotificationKind.paymentReviewed,
      recipientId: to,
      actorId: 'omar',
      teamId: 't1',
      target: const NotificationTarget.payment('p1'),
      amount: full ? const Money(18000) : null,
      concept: full ? 'Café' : null,
      debtCount: full ? 2 : null,
      rejectedCount: full ? 1 : null,
      note: full ? 'no llegó' : null,
      templateKey: full ? 'askIfPaid' : null,
    ),
  );

  Future<void> save(InboxNotification n) =>
      db.inboxDao.upsert(InboxNotificationMapper.toCompanion(n));

  test('a notification round-trips with all its optional data', () async {
    await save(note('n1', full: true));
    await save(note('n2'));

    final rows = await db.inboxDao.watchFor('ana').first;
    final mapped = rows.map(InboxNotificationMapper.toDomain).toList();

    expect(mapped, containsAll([note('n1', full: true), note('n2')]));
  });

  test('newest first and only for the recipient', () async {
    await save(note('old'));
    await save(note('new', created: at.add(const Duration(minutes: 5))));
    await save(note('other', to: 'beto'));

    final rows = await db.inboxDao.watchFor('ana').first;

    expect(rows.map((r) => r.id), ['new', 'old']);
  });

  test('unread count follows reading (N2)', () async {
    await save(note('n1'));
    await save(note('n2'));
    await save(note('n3', to: 'beto'));
    final counts = db.inboxDao.watchUnreadCount('ana');
    expect(await counts.first, 2);

    await db.inboxDao.markRead('n1', at);
    expect(await counts.first, 1);

    await db.inboxDao.markAllRead('ana', at);
    expect(await counts.first, 0);
    expect(await db.inboxDao.watchUnreadCount('beto').first, 1);
  });

  test('marking read twice keeps the first read time', () async {
    await save(note('n1'));
    final later = at.add(const Duration(hours: 1));

    await db.inboxDao.markRead('n1', at);
    await db.inboxDao.markRead('n1', later);

    final row = (await db.inboxDao.watchFor('ana').first).single;
    expect(row.readAt!.isAtSameMomentAs(at), isTrue);
  });

  test('remove clears a notification', () async {
    await save(note('n1'));

    await db.inboxDao.remove('n1');

    expect(await db.inboxDao.watchFor('ana').first, isEmpty);
  });
}
