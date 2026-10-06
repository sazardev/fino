import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/analytics/analytics_service_provider.dart';
import '../core/flavor/flavor_config_provider.dart';
import '../core/notifications/notifications_coordinator_provider.dart';

/// Starts what the first frame does not need: analytics collection and
/// notifications. Runs after that frame, so cold start stays fast.
Future<void> startDeferredServices(ProviderContainer container) async {
  final config = container.read(flavorConfigProvider);
  await container
      .read(analyticsServiceProvider)
      .setCollectionEnabled(enabled: config.analyticsEnabled);
  await container.read(notificationsCoordinatorProvider).start();
}
