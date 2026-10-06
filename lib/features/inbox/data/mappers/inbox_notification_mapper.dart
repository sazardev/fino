import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/money/money.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../../domain/entities/inbox_notification.dart';

/// Fila local ↔ [InboxNotification].
abstract final class InboxNotificationMapper {
  static InboxNotification toDomain(InboxNotificationRow row) =>
      InboxNotification(
        id: row.id,
        createdAt: row.createdAt.toUtc(),
        readAt: row.readAt?.toUtc(),
        intent: NotificationIntent(
          kind: row.kind,
          recipientId: row.recipientId,
          actorId: row.actorId,
          teamId: row.teamId,
          target: NotificationTarget(row.targetType, row.targetId),
          amount: row.amountCents == null ? null : Money(row.amountCents!),
          concept: row.concept,
          debtCount: row.debtCount,
          rejectedCount: row.rejectedCount,
          note: row.note,
          templateKey: row.templateKey,
        ),
      );

  static InboxNotificationsCompanion toCompanion(
    InboxNotification notification,
  ) {
    final intent = notification.intent;
    return InboxNotificationsCompanion.insert(
      id: notification.id,
      recipientId: intent.recipientId,
      kind: intent.kind,
      actorId: intent.actorId,
      teamId: intent.teamId,
      targetType: intent.target.type,
      targetId: intent.target.id,
      amountCents: Value(intent.amount?.cents),
      concept: Value(intent.concept),
      debtCount: Value(intent.debtCount),
      rejectedCount: Value(intent.rejectedCount),
      note: Value(intent.note),
      templateKey: Value(intent.templateKey),
      createdAt: notification.createdAt,
      readAt: Value(notification.readAt),
    );
  }
}
