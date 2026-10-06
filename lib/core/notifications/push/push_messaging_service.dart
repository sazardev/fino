import '../notification_payload.dart';
import 'push_message.dart';

/// Push notifications (FCM).
abstract interface class PushMessagingService {
  /// Asks for the notification permission; `true` when granted.
  Future<bool> requestPermission();

  /// This device's FCM token, once it exists.
  Future<String?> token();

  Stream<String> get tokenRefreshes;

  /// Messages received while the app is in the foreground.
  Stream<PushMessage> get foregroundMessages;

  /// Taps that opened the app, including the message that launched it.
  Stream<NotificationPayload> get opened;
}
