import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/notifications/intent/notification_intent.dart';

part 'inbox_notification.freezed.dart';

/// Una notificación en el buzón de su destinatario (SPEC N2): la fuente de
/// verdad, aunque el push falle.
@freezed
abstract class InboxNotification with _$InboxNotification {
  const factory({
    required String id,
    required NotificationIntent intent,
    required DateTime createdAt,
    DateTime? readAt,
  }) = _InboxNotification;
}
