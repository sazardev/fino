import 'package:fino/app/fino_app.dart';
import 'package:fino/app/home/home_page.dart';
import 'package:fino/app/settings/app_settings.dart';
import 'package:fino/app/splash/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test/support/test_overrides.dart';

/// Boots the real app on a device or browser with Firebase and platform
/// services replaced, and checks the first screen is reachable.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('cold start reaches the signed-in home', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final settings = AppSettings(await SharedPreferences.getInstance());

    await tester.pumpWidget(
      ProviderScope(
        overrides: testOverrides(settings: settings),
        child: const FinoApp(),
      ),
    );
    await tester.tap(find.byType(SplashScreen));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
