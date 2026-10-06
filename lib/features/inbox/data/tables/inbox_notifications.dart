import 'package:drift/drift.dart';

import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target_type.dart';

/// Buzón de notificaciones del usuario (espejo de `users/{uid}/inbox/{id}`).
@DataClassName('InboxNotificationRow')
@TableIndex(name: 'inbox_recipient', columns: {#recipientId, #createdAt})
class InboxNotifications extends Table {
  TextColumn get id => text()();
  TextColumn get recipientId => text()();
  TextColumn get kind => textEnum<NotificationKind>()();
  TextColumn get actorId => text()();
  TextColumn get teamId => text()();
  TextColumn get targetType => textEnum<NotificationTargetType>()();
  TextColumn get targetId => text()();
  IntColumn get amountCents => integer().nullable()();
  TextColumn get concept => text().nullable()();
  IntColumn get debtCount => integer().nullable()();
  IntColumn get rejectedCount => integer().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get templateKey => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get readAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
