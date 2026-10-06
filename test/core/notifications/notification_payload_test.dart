import 'package:fino/core/notifications/notification_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses an in-app route', () {
    expect(
      NotificationPayload.tryParse('/ajustes'),
      const NotificationPayload('/ajustes'),
    );
  });

  test('ignores payloads that are not in-app routes', () {
    expect(NotificationPayload.tryParse(null), isNull);
    expect(NotificationPayload.tryParse('https://evil.com'), isNull);
    expect(NotificationPayload.tryParse('//evil.com'), isNull);
  });
}
