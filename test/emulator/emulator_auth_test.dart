import 'package:fino/core/emulators/emulator_config.dart';
import 'package:fino/core/http/io_json_post.dart';
import 'package:fino/features/auth/data/emulator_auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/in_memory_session_store.dart';
import 'emulator_test_support.dart';

/// Runs against the real Auth emulator (`tool/emulators.sh`) and skips itself
/// when it is not up.
void main() {
  const emulators = EmulatorConfig(authPort: 9099, firestorePort: 8085);
  late bool running;

  // The emulators run on this computer, like Linux sees them (a test host
  // would otherwise default to Android's 10.0.2.2).
  setUpAll(() async {
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    running = await emulatorsRunning();
  });
  tearDownAll(() => debugDefaultTargetPlatformOverride = null);

  test('the REST repository signs in against the real Auth emulator', () async {
    if (!running) {
      markTestSkipped('Firebase emulators are not running');
      return;
    }
    final repository = EmulatorAuthRepository(
      emulators: emulators,
      post: ioJsonPost,
      store: InMemorySessionStore(),
    );

    await repository.signInWithGoogle();

    final user = await repository.watchUser().first;
    expect(user?.email, 'dev@fino.test');
    expect(user?.uid, isNotEmpty);
  });
}
