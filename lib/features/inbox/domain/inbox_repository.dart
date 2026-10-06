import 'entities/inbox_notification.dart';

/// El buzón de notificaciones del usuario (SPEC N2): la fuente de verdad,
/// aunque el push falle. Offline-first.
abstract interface class InboxRepository {
  /// Las más recientes primero.
  Stream<List<InboxNotification>> watch(String userId);

  Stream<int> watchUnreadCount(String userId);

  Future<void> markRead(String userId, String notificationId);

  Future<void> markAllRead(String userId);

  Future<void> remove(String userId, String notificationId);
}
