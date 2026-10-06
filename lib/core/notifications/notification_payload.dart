import 'package:flutter/foundation.dart';

import '../routing/in_app_location.dart';

/// What a notification asks the app to do when tapped: open a route.
///
/// Travels as the local notification's payload and as the `route` data key of
/// a push message.
@immutable
class NotificationPayload {
  const new(this.location);

  /// FCM data key carrying the location.
  static const dataKey = 'route';

  /// An in-app location such as `/ajustes`.
  final String location;

  /// `null` unless [raw] is an in-app location (`/…`, not `//host` or a URL).
  static NotificationPayload? tryParse(String? raw) {
    final location = inAppLocationOrNull(raw);
    return location == null ? null : NotificationPayload(location);
  }

  @override
  bool operator ==(Object other) =>
      other is NotificationPayload && other.location == location;

  @override
  int get hashCode => location.hashCode;
}
