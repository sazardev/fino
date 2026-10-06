import 'dart:async';

import 'local/local_notifications_service.dart';
import 'notification_payload.dart';
import 'push/push_messaging_service.dart';

/// Wires push and local notifications together and exposes one stream of
/// "open this route" requests, whatever notification produced it.
class NotificationsCoordinator {
  new({required this._local, required this._push});

  final LocalNotificationsService _local;
  final PushMessagingService _push;
  final _subscriptions = <StreamSubscription<Object?>>[];
  final _opens = StreamController<NotificationPayload>.broadcast();

  var _started = false;
  var _nextId = 0;

  /// Routes the user asked to open by tapping a notification.
  Stream<NotificationPayload> get opens => _opens.stream;

  /// Starts listening. Call once, after the first frame.
  Future<void> start() async {
    if (_started) return;
    _started = true;
    _subscriptions
      ..add(_local.taps.listen(_opens.add))
      ..add(_push.opened.listen(_opens.add))
      ..add(
        _push.foregroundMessages.listen(
          (message) => _local.show(
            id: _nextId++,
            title: message.title,
            body: message.body,
            payload: message.payload,
          ),
        ),
      );
    await _local.initialize();
  }

  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _opens.close();
  }
}
