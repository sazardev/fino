import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local/local_notifications_service_provider.dart';
import 'notifications_coordinator.dart';
import 'push/push_messaging_service_provider.dart';

part 'notifications_coordinator_provider.g.dart';

@Riverpod(keepAlive: true)
NotificationsCoordinator notificationsCoordinator(Ref ref) {
  final coordinator = NotificationsCoordinator(
    local: ref.watch(localNotificationsServiceProvider),
    push: ref.watch(pushMessagingServiceProvider),
  );
  ref.onDispose(coordinator.dispose);
  return coordinator;
}
