import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../tables/inbox_notifications.dart';

part 'inbox_dao.g.dart';

/// Consultas locales del buzón de notificaciones.
@DriftAccessor(tables: [InboxNotifications])
class InboxDao extends DatabaseAccessor<AppDatabase> with _$InboxDaoMixin {
  new(super.attachedDatabase);

  Future<void> upsert(InboxNotificationsCompanion notification) =>
      into(inboxNotifications).insertOnConflictUpdate(notification);

  Future<InboxNotificationRow?> find(String id) => (select(
    inboxNotifications,
  )..where((n) => n.id.equals(id))).getSingleOrNull();

  Future<List<InboxNotificationRow>> unreadOf(String recipientId) => (select(
    inboxNotifications,
  )..where((n) => n.recipientId.equals(recipientId) & n.readAt.isNull())).get();

  Stream<List<InboxNotificationRow>> watchFor(String recipientId) =>
      (select(inboxNotifications)
            ..where((n) => n.recipientId.equals(recipientId))
            ..orderBy([(n) => OrderingTerm.desc(n.createdAt)]))
          .watch();

  Stream<int> watchUnreadCount(String recipientId) {
    final count = inboxNotifications.id.count();
    final query = selectOnly(inboxNotifications)
      ..addColumns([count])
      ..where(
        inboxNotifications.recipientId.equals(recipientId) &
            inboxNotifications.readAt.isNull(),
      );
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  Future<void> markRead(String id, DateTime at) =>
      (update(inboxNotifications)
            ..where((n) => n.id.equals(id) & n.readAt.isNull()))
          .write(InboxNotificationsCompanion(readAt: Value(at)));

  Future<void> markAllRead(String recipientId, DateTime at) =>
      (update(inboxNotifications)..where(
            (n) => n.recipientId.equals(recipientId) & n.readAt.isNull(),
          ))
          .write(InboxNotificationsCompanion(readAt: Value(at)));

  Future<Set<String>> idsOf(String recipientId) async => {
    for (final row in await (select(
      inboxNotifications,
    )..where((n) => n.recipientId.equals(recipientId))).get())
      row.id,
  };

  Future<void> remove(String id) =>
      (delete(inboxNotifications)..where((n) => n.id.equals(id))).go();
}
