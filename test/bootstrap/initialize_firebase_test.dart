import 'package:fino/bootstrap/initialize_firebase.dart';
import 'package:fino/core/flavor/configs/prod_flavor_config.dart';
import 'package:fino/core/logging/app_logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('production refuses to start with unconfigured Firebase', () {
    // Passes until `tool/configure_firebase.sh prod` has been run, then the
    // options are real and this guard no longer applies.
    expect(
      () =>
          initializeFirebase(prodFlavorConfig, const AppLogger(verbose: false)),
      throwsStateError,
    );
  });
}
