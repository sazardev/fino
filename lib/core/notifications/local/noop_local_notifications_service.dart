import '../notification_payload.dart';
import 'local_notifications_service.dart';

/// Local notifications are Android-only; the web does nothing.
class NoopLocalNotificationsService implements LocalNotificationsService {
  @override
  Future<void> initialize() async {}

  @override
  Future<bool> requestPermission() async => false;

  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
    NotificationPayload? payload,
  }) async {}

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    NotificationPayload? payload,
  }) async {}

  @override
  Future<void> cancel(int id) async {}

  @override
  Stream<NotificationPayload> get taps => const Stream.empty();
}
