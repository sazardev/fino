import 'package:fino/core/emulators/emulator_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const emulators = EmulatorConfig(authPort: 9099, firestorePort: 8085);

  tearDown(() => debugDefaultTargetPlatformOverride = null);

  test('the Android emulator reaches the computer at 10.0.2.2', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(emulators.host, '10.0.2.2');
  });

  test('every other platform uses localhost', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    expect(emulators.host, 'localhost');
  });
}
