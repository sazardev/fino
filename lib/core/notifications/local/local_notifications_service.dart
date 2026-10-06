import '../notification_payload.dart';

/// Notifications the app raises itself.
abstract interface class LocalNotificationsService {
  /// Registers channels and tap handling. Safe to call once, at startup.
  Future<void> initialize();

  /// Asks for the notification permission; `true` when granted.
  Future<bool> requestPermission();

  Future<void> show({
    required int id,
    required String title,
    required String body,
    NotificationPayload? payload,
  });

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    NotificationPayload? payload,
  });

  Future<void> cancel(int id);

  /// Taps on notifications, including the one that launched the app.
  Stream<NotificationPayload> get taps;
}
