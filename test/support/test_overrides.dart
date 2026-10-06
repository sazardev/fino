import 'package:fino/app/settings/app_settings.dart';
import 'package:fino/app/settings/app_settings_provider.dart';
import 'package:fino/core/analytics/analytics_service_provider.dart';
import 'package:fino/core/flavor/flavor_config_provider.dart';
import 'package:fino/core/notifications/local/local_notifications_service_provider.dart';
import 'package:fino/core/notifications/local/noop_local_notifications_service.dart';
import 'package:fino/core/notifications/push/noop_push_messaging_service.dart';
import 'package:fino/core/notifications/push/push_messaging_service_provider.dart';
import 'package:fino/features/auth/domain/auth_repository.dart';
import 'package:fino/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:fino/features/changelog/domain/changelog_repository.dart';
import 'package:fino/features/changelog/presentation/providers/changelog_repository_provider.dart';
import 'package:flutter_riverpod/misc.dart';

import 'fake_auth_repository.dart';
import 'fake_changelog_repository.dart';
import 'recording_analytics_service.dart';
import 'test_flavor_config.dart';

/// Replaces every provider that would reach Firebase or a platform plugin.
List<Override> testOverrides({
  required AppSettings settings,
  AuthRepository? auth,
  RecordingAnalyticsService? analytics,
  ChangelogRepository? changelog,
}) => [
  flavorConfigProvider.overrideWithValue(testFlavorConfig),
  appSettingsProvider.overrideWithValue(settings),
  authRepositoryProvider.overrideWithValue(
    auth ?? FakeAuthRepository(user: testUser),
  ),
  analyticsServiceProvider.overrideWithValue(
    analytics ?? RecordingAnalyticsService(),
  ),
  localNotificationsServiceProvider.overrideWithValue(
    NoopLocalNotificationsService(),
  ),
  pushMessagingServiceProvider.overrideWithValue(NoopPushMessagingService()),
  changelogRepositoryProvider.overrideWithValue(
    changelog ?? FakeChangelogRepository(),
  ),
];
