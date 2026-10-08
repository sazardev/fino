import 'package:fino/bootstrap/initialize_firebase.dart';
import 'package:fino/core/firebase/options/firebase_options_x.dart';
import 'package:fino/core/flavor/configs/dev_flavor_config.dart';
import 'package:fino/core/flavor/flavor.dart';
import 'package:fino/core/flavor/flavor_config.dart';
import 'package:fino/core/logging/app_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const logger = AppLogger(verbose: false);

  // Strict (production-like) but with placeholder Firebase, so the platform
  // checks are exercised without touching a real project.
  const unconfigured = FlavorConfig(
    flavor: Flavor.prod,
    appName: 'Fino Unconfigured',
    firebaseOptions: FirebaseOptions(
      apiKey: FirebaseOptionsX.placeholder,
      appId: FirebaseOptionsX.placeholder,
      messagingSenderId: FirebaseOptionsX.placeholder,
      projectId: 'fino-unconfigured',
    ),
    googleServerClientId: FirebaseOptionsX.placeholder,
    deepLinkHost: 'fino.example',
    verboseLogging: false,
    analyticsEnabled: false,
    strictConfiguration: true,
  );

  test('a strict flavor refuses to start with unconfigured Firebase', () {
    expect(() => initializeFirebase(unconfigured, logger), throwsStateError);
  });

  group('on Linux, where Firebase has no plugins', () {
    setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.linux);
    tearDown(() => debugDefaultTargetPlatformOverride = null);

    test('an emulated flavor starts without touching Firebase', () async {
      await expectLater(initializeFirebase(devFlavorConfig, logger), completes);
    });

    test('a flavor without emulators is refused, and says why', () {
      expect(
        () => initializeFirebase(unconfigured, logger),
        throwsA(
          isA<UnsupportedError>().having(
            (e) => e.message,
            'message',
            contains('Linux'),
          ),
        ),
      );
    });
  });
}
