import 'package:fino/bootstrap/initialize_firebase.dart';
import 'package:fino/core/flavor/configs/dev_flavor_config.dart';
import 'package:fino/core/flavor/configs/prod_flavor_config.dart';
import 'package:fino/core/logging/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const logger = AppLogger(verbose: false);

  test('production refuses to start with unconfigured Firebase', () {
    // Passes until `tool/configure_firebase.sh prod` has been run, then the
    // options are real and this guard no longer applies.
    expect(
      () => initializeFirebase(prodFlavorConfig, logger),
      throwsStateError,
    );
  });

  group('on Linux, where Firebase has no plugins', () {
    setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.linux);
    tearDown(() => debugDefaultTargetPlatformOverride = null);

    test('an emulated flavor starts without touching Firebase', () async {
      await expectLater(initializeFirebase(devFlavorConfig, logger), completes);
    });

    test('a flavor without emulators is refused, and says why', () {
      expect(
        () => initializeFirebase(prodFlavorConfig, logger),
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
