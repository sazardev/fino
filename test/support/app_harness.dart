import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fino/app/fino_app.dart';
import 'package:fino/app/settings/app_settings.dart';
import 'package:fino/app/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Pumps the whole app at [size] and taps past the splash.
Future<AppSettings> pumpFino(
  WidgetTester tester, {
  Size size = const Size(390, 844),
  Map<String, Object> stored = const {},
}) async {
  SharedPreferences.setMockInitialValues(stored);
  final settings = AppSettings(await SharedPreferences.getInstance());

  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(FinoApp(settings: settings));
  await tester.tap(find.byType(SplashScreen));
  await tester.pumpAndSettle();
  return settings;
}
