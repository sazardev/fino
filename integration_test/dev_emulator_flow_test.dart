import 'dart:io';

import 'package:fino/app/home/home_page.dart';
import 'package:fino/app/splash/splash_screen.dart';
import 'package:fino/bootstrap/bootstrap.dart';
import 'package:fino/core/flavor/configs/dev_flavor_config.dart';
import 'package:fino/features/auth/presentation/pages/sign_in_page.dart';
import 'package:fino/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The real dev build, end to end: `bootstrap` → splash → sign-in against the
/// Auth emulator → home. Needs `tool/emulators.sh`; skips itself otherwise.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('dev boots, signs in through the emulator and reaches home', (
    tester,
  ) async {
    final host = devFlavorConfig.emulators!.host;
    try {
      final socket = await Socket.connect(
        host,
        devFlavorConfig.emulators!.authPort,
        timeout: const Duration(seconds: 1),
      );
      await socket.close();
    } on Object {
      markTestSkipped('Firebase emulators are not running');
      return;
    }

    SharedPreferences.setMockInitialValues({});
    await bootstrap(devFlavorConfig);
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.byType(SplashScreen));
    await tester.pumpAndSettle();
    expect(find.byType(SignInPage), findsOneWidget);

    await tester.tap(find.byType(GoogleSignInButton));
    for (var i = 0; i < 50 && find.byType(HomePage).evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    debugPrint('home reached on ${defaultTargetPlatform.name}');
  });
}
