import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../notification_payload.dart';
import 'push_message.dart';
import 'push_messaging_service.dart';

class FirebasePushMessagingService implements PushMessagingService {
  new(this._messaging);

  final FirebaseMessaging _messaging;

  @override
  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  Future<String?> token() => _messaging.getToken();

  @override
  Stream<String> get tokenRefreshes => _messaging.onTokenRefresh;

  @override
  Stream<PushMessage> get foregroundMessages => FirebaseMessaging.onMessage
      .where((message) => message.notification != null)
      .map(
        (message) => PushMessage(
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          payload: _payloadOf(message),
        ),
      );

  @override
  Stream<NotificationPayload> get opened async* {
    final launch = await _messaging.getInitialMessage();
    final launchPayload = launch == null ? null : _payloadOf(launch);
    if (launchPayload != null) yield launchPayload;
    yield* FirebaseMessaging.onMessageOpenedApp
        .map(_payloadOf)
        .where((payload) => payload != null)
        .cast<NotificationPayload>();
  }

  NotificationPayload? _payloadOf(RemoteMessage message) =>
      NotificationPayload.tryParse(
        message.data[NotificationPayload.dataKey] as String?,
      );
}
