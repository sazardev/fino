import '../notification_payload.dart';
import 'push_message.dart';
import 'push_messaging_service.dart';

/// Push is Android-only for now; the web does nothing.
class NoopPushMessagingService implements PushMessagingService {
  @override
  Future<bool> requestPermission() async => false;

  @override
  Future<String?> token() async => null;

  @override
  Stream<String> get tokenRefreshes => const Stream.empty();

  @override
  Stream<PushMessage> get foregroundMessages => const Stream.empty();

  @override
  Stream<NotificationPayload> get opened => const Stream.empty();
}
