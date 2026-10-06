import '../../../../core/notifications/inbox_document.dart';
import '../../../../core/sync/pull/scoped_collection_applier.dart';
import '../../../../core/sync/remote_document.dart';
import '../../domain/entities/inbox_notification.dart';
import '../mappers/inbox_notification_mapper.dart';

/// `users/{uid}/inbox` → Drift.
class InboxApplier extends ScopedCollectionApplier {
  const new(super.db, this.userId);

  final String userId;

  @override
  Future<void> upsert(RemoteDocument document) {
    final fields = document.fields;
    return db.inboxDao.upsert(
      InboxNotificationMapper.toCompanion(
        InboxNotification(
          id: document.id,
          intent: InboxDocument.fromFields(fields, recipientId: userId),
          createdAt: fields['createdAt']! as DateTime,
          readAt: fields['readAt'] as DateTime?,
        ),
      ),
    );
  }

  @override
  Future<void> delete(String id) => db.inboxDao.remove(id);

  @override
  Future<Set<String>> localIds() => db.inboxDao.idsOf(userId);

  @override
  String pathOf(String id) => '${InboxDocument.collectionOf(userId)}/$id';
}
