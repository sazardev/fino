import 'package:drift/native.dart';
import 'package:fino/bootstrap/sign_in_demo_user.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/database/app_database_provider.dart';
import 'package:fino/core/flavor/flavor_config.dart';
import 'package:fino/core/flavor/flavor_config_provider.dart';
import 'package:fino/core/logging/app_logger.dart';
import 'package:fino/features/auth/domain/auth_user.dart';
import 'package:fino/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_auth_repository.dart';
import '../support/test_flavor_config.dart';

void main() {
  const logger = AppLogger(verbose: false);
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<AuthUser?> runWith(
    FlavorConfig flavor,
    FakeAuthRepository auth,
  ) async {
    final container = ProviderContainer(
      overrides: [
        flavorConfigProvider.overrideWithValue(flavor),
        authRepositoryProvider.overrideWithValue(auth),
        appDatabaseProvider.overrideWithValue(db),
      ],
    );
    addTearDown(container.dispose);

    await signInDemoUser(container, logger);
    final user = await auth.watchUser().first;
    return user;
  }

  test('signs in as the demo person in a demo session', () async {
    expect(await runWith(testDemoFlavorConfig, FakeAuthRepository()), testUser);
  });

  test('keeps a session that was already restored', () async {
    const someoneElse = AuthUser(uid: 'u9', displayName: 'Otra');

    expect(
      await runWith(
        testDemoFlavorConfig,
        FakeAuthRepository(user: someoneElse),
      ),
      someoneElse,
    );
  });

  test('does nothing outside a demo session', () async {
    expect(
      await runWith(testEmulatedFlavorConfig, FakeAuthRepository()),
      isNull,
    );
  });

  test('a failed sign-in leaves the person at the sign-in screen', () async {
    final auth = FakeAuthRepository()..signInError = Exception('no emulator');

    expect(await runWith(testDemoFlavorConfig, auth), isNull);
  });
}
