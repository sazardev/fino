import 'package:flutter/foundation.dart';

import '../notification_payload.dart';

/// A push message that arrived while the app is open.
@immutable
class PushMessage {
  const new({required this.title, required this.body, this.payload});

  final String title;
  final String body;
  final NotificationPayload? payload;
}
