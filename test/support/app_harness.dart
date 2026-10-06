import 'package:fino/app/fino_app.dart';
import 'package:fino/app/settings/app_settings.dart';
import 'package:fino/app/splash/splash_screen.dart';
import 'package:fino/features/auth/domain/auth_repository.dart';
import 'package:fino/features/changelog/domain/changelog_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'recording_analytics_service.dart';
import 'test_overrides.dart';

/// Pumps the whole app at [size] and taps past the splash.
///
/// Signed in by default; pass [auth] to control the session, and
/// [initialLocation] to start from a deep link.
Future<AppSettings> pumpFino(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  Map<String, Object> stored = const {},
  AuthRepository? auth,
  RecordingAnalyticsService? analytics,
  ChangelogRepository? changelog,
  String? initialLocation,
}) async {
  SharedPreferences.setMockInitialValues(stored);
  final settings = AppSettings(await SharedPreferences.getInstance());

  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  if (initialLocation != null) {
    tester.binding.platformDispatcher.defaultRouteNameTestValue =
        initialLocation;
    addTearDown(
      tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
    );
  }

  await tester.pumpWidget(
    ProviderScope(
      overrides: testOverrides(
        settings: settings,
        auth: auth,
        analytics: analytics,
        changelog: changelog,
      ),
      child: const FinoApp(),
    ),
  );
  await tester.tap(find.byType(SplashScreen));
  await tester.pumpAndSettle();
  return settings;
}
