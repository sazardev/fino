import 'dart:async';

import 'package:go_router/go_router.dart';

import '../../core/notifications/notification_payload.dart';

/// Sends the router wherever a tapped notification asks. Returns the
/// subscription to cancel on dispose.
StreamSubscription<NotificationPayload> openNotificationRoutes({
  required GoRouter router,
  required Stream<NotificationPayload> opens,
}) => opens.listen((payload) => router.go(payload.location));
