import 'package:drift/native.dart';
import 'package:fino/app/demo/demo_data_provider.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/database/app_database_provider.dart';
import 'package:fino/core/flavor/flavor_config.dart';
import 'package:fino/core/flavor/flavor_config_provider.dart';
import 'package:fino/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:fino/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';
import '../../support/test_flavor_config.dart';

void main() {
  late AppDatabase db;
  late FakeAuthRepository auth;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    auth = FakeAuthRepository();
  });
  tearDown(() => db.close());

  ProviderContainer start(FlavorConfig flavor) {
    final container = ProviderContainer(
      overrides: [
        flavorConfigProvider.overrideWithValue(flavor),
        authRepositoryProvider.overrideWithValue(auth),
        appDatabaseProvider.overrideWithValue(db),
      ],
    );
    addTearDown(container.dispose);
    container
      ..listen(authStateProvider, (_, _) {})
      ..read(demoDataProvider);
    return container;
  }

  Future<int> teamCount() async => (await db.select(db.teams).get()).length;

  test('fills the database once someone signs in', () async {
    start(testDemoFlavorConfig);
    await pumpEventQueue();
    expect(await teamCount(), 0);

    await auth.signInWithGoogle();
    await pumpEventQueue();

    expect(await teamCount(), 2);
  });

  test('fills it for a session restored at startup', () async {
    auth = FakeAuthRepository(user: testUser);
    start(testDemoFlavorConfig);
    await pumpEventQueue();

    expect(await teamCount(), 2);
  });

  test('fills it again after signing out wiped it', () async {
    auth = FakeAuthRepository(user: testUser);
    start(testDemoFlavorConfig);
    await pumpEventQueue();

    await auth.signOut();
    await db.wipe();
    await pumpEventQueue();
    expect(await teamCount(), 0);

    await auth.signInWithGoogle();
    await pumpEventQueue();
    expect(await teamCount(), 2);
  });

  test('leaves the database alone outside a demo session', () async {
    auth = FakeAuthRepository(user: testUser);
    start(testEmulatedFlavorConfig);
    await pumpEventQueue();

    expect(await teamCount(), 0);
  });
}
