import '../../../core/database/app_database.dart';
import '../../../core/database/outbox_operation.dart';
import '../../../core/ids/id_generator.dart';
import '../../../core/notifications/inbox_document.dart';
import '../../../core/sync/remote_marker.dart';
import '../../../core/sync/remote_write.dart';
import '../../../core/time/clock.dart';
import '../domain/entities/inbox_notification.dart';
import '../domain/inbox_repository.dart';
import 'mappers/inbox_notification_mapper.dart';

/// El buzón leído de Drift. Marcar leída o borrar se guarda primero ahí y
/// deja su escritura lista en el outbox.
class LocalInboxRepository implements InboxRepository {
  const new(this._db, this._newId, this._clock);

  final AppDatabase _db;
  final IdGenerator _newId;
  final Clock _clock;

  @override
  Stream<List<InboxNotification>> watch(String userId) => _db.inboxDao
      .watchFor(userId)
      .map((rows) => rows.map(InboxNotificationMapper.toDomain).toList());

  @override
  Stream<int> watchUnreadCount(String userId) =>
      _db.inboxDao.watchUnreadCount(userId);

  @override
  Future<void> markRead(String userId, String notificationId) async {
    final row = await _db.inboxDao.find(notificationId);
    if (row == null || row.readAt != null || row.recipientId != userId) return;
    await _markRead(userId, [notificationId]);
  }

  @override
  Future<void> markAllRead(String userId) async {
    final unread = await _db.inboxDao.unreadOf(userId);
    if (unread.isEmpty) return;
    await _markRead(userId, [for (final row in unread) row.id]);
  }

  @override
  Future<void> remove(String userId, String notificationId) async {
    final row = await _db.inboxDao.find(notificationId);
    if (row == null || row.recipientId != userId) return;
    await _db.transaction(() async {
      await _db.inboxDao.remove(notificationId);
      await _db.outboxDao.enqueueBatch(
        [
          RemoteWrite(
            collection: InboxDocument.collectionOf(userId),
            id: notificationId,
            operation: OutboxOperation.delete,
          ),
        ],
        batchId: _newId(),
        now: _clock(),
      );
    });
  }

  Future<void> _markRead(String userId, List<String> ids) async {
    final now = _clock();
    await _db.transaction(() async {
      for (final id in ids) {
        await _db.inboxDao.markRead(id, now);
      }
      await _db.outboxDao.enqueueBatch(
        [
          for (final id in ids)
            RemoteWrite(
              collection: InboxDocument.collectionOf(userId),
              id: id,
              operation: OutboxOperation.update,
              fields: const {'readAt': RemoteMarker.serverTimestamp},
            ),
        ],
        batchId: _newId(),
        now: now,
      );
    });
  }
}
