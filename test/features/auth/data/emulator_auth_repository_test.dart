import 'package:fino/core/emulators/emulator_config.dart';
import 'package:fino/features/auth/data/emulator_auth_repository.dart';
import 'package:fino/features/auth/domain/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/in_memory_session_store.dart';

void main() {
  const emulators = EmulatorConfig(authPort: 9099, firestorePort: 8085);
  late InMemorySessionStore store;
  late List<(Uri, Map<String, Object?>)> requests;
  late EmulatorAuthRepository repository;

  const signedIn = AuthUser(
    uid: 'uid1',
    displayName: 'Dev Fino',
    email: 'dev@fino.test',
  );

  EmulatorAuthRepository build({AuthUser? stored}) {
    store = InMemorySessionStore(stored);
    requests = [];
    return EmulatorAuthRepository(
      emulators: emulators,
      store: store,
      post: (url, body) async {
        requests.add((url, body));
        return {
          'localId': 'uid1',
          'displayName': 'Dev Fino',
          'email': 'dev@fino.test',
        };
      },
    );
  }

  setUp(() => repository = build());

  test('starts signed out when nothing was stored', () {
    expect(repository.watchUser(), emits(isNull));
  });

  test('restores the stored session', () {
    repository = build(stored: signedIn);
    expect(repository.watchUser(), emits(signedIn));
  });

  test('signing in calls the emulator with a fake Google identity', () async {
    await repository.signInWithGoogle();

    final (url, body) = requests.single;
    expect(url.host, emulators.host);
    expect(url.port, 9099);
    expect(url.path, endsWith('accounts:signInWithIdp'));
    expect(body['postBody'], contains('providerId=google.com'));
    expect(body['postBody'], contains('dev%40fino.test'));
  });

  test('signing in stores and emits the user', () async {
    final seen = <AuthUser?>[];
    final subscription = repository.watchUser().listen(seen.add);
    addTearDown(subscription.cancel);
    await pumpEventQueue();

    await repository.signInWithGoogle();
    await pumpEventQueue();

    expect(seen, [null, signedIn]);
    expect(store.user, signedIn);
  });

  test('signing out forgets the session', () async {
    repository = build(stored: signedIn);

    await repository.signOut();

    expect(store.user, isNull);
  });

  test('a rejected sign-in leaves the session untouched', () async {
    repository = EmulatorAuthRepository(
      emulators: emulators,
      store: store,
      post: (_, _) async => throw StateError('emulator is down'),
    );

    await expectLater(repository.signInWithGoogle(), throwsStateError);

    expect(store.user, isNull);
  });
}
