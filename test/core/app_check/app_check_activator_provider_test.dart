import 'package:fino/core/app_check/app_check_activator_provider.dart';
import 'package:fino/core/app_check/noop_app_check_activator.dart';
import 'package:fino/core/platform/app_check_supported.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() => debugDefaultTargetPlatformOverride = null);

  test('App Check attestation is Android-only', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    expect(appCheckSupported, isTrue);

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(appCheckSupported, isFalse);

    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    expect(appCheckSupported, isFalse);
  });

  test('where App Check is not supported, it is a no-op', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;

    final container = ProviderContainer();
    addTearDown(container.dispose);
    final activator = container.read(appCheckActivatorProvider);

    expect(activator, isA<NoopAppCheckActivator>());
    await activator.activate();
  });
}
