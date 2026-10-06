import 'dart:async';

import 'package:fino/core/notifications/local/local_notifications_service.dart';
import 'package:fino/core/notifications/notification_payload.dart';
import 'package:fino/core/notifications/notifications_coordinator.dart';
import 'package:fino/core/notifications/push/push_message.dart';
import 'package:fino/core/notifications/push/push_messaging_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocal extends Mock implements LocalNotificationsService;

class _MockPush extends Mock implements PushMessagingService;

void main() {
  late _MockLocal local;
  late _MockPush push;
  late StreamController<NotificationPayload> taps;
  late StreamController<NotificationPayload> opened;
  late StreamController<PushMessage> foreground;
  late NotificationsCoordinator coordinator;

  setUp(() {
    local = _MockLocal();
    push = _MockPush();
    taps = StreamController.broadcast();
    opened = StreamController.broadcast();
    foreground = StreamController.broadcast();
    when(() => local.taps).thenAnswer((_) => taps.stream);
    when(() => local.initialize()).thenAnswer((_) async {});
    when(
      () => local.show(
        id: any(named: 'id'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        payload: any(named: 'payload'),
      ),
    ).thenAnswer((_) async {});
    when(() => push.opened).thenAnswer((_) => opened.stream);
    when(() => push.foregroundMessages).thenAnswer((_) => foreground.stream);
    coordinator = NotificationsCoordinator(local: local, push: push);
  });

  tearDown(() async {
    await coordinator.dispose();
    await taps.close();
    await opened.close();
    await foreground.close();
  });

  test('start initializes local notifications once', () async {
    await coordinator.start();
    await coordinator.start();
    verify(() => local.initialize()).called(1);
  });

  test('a tapped local or push notification asks to open its route', () async {
    await coordinator.start();
    final opens = <NotificationPayload>[];
    coordinator.opens.listen(opens.add);

    taps.add(const NotificationPayload('/a'));
    opened.add(const NotificationPayload('/b'));
    await pumpEventQueue();

    expect(opens, const [NotificationPayload('/a'), NotificationPayload('/b')]);
  });

  test('a foreground push shows as a local notification', () async {
    await coordinator.start();
    foreground.add(
      const PushMessage(
        title: 'Hola',
        body: 'Mundo',
        payload: NotificationPayload('/c'),
      ),
    );
    await pumpEventQueue();

    verify(
      () => local.show(
        id: 0,
        title: 'Hola',
        body: 'Mundo',
        payload: const NotificationPayload('/c'),
      ),
    ).called(1);
  });
}
