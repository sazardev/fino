import 'package:fino/features/auth/data/shared_preferences_session_store.dart';
import 'package:fino/features/auth/domain/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const user = AuthUser(
    uid: 'u1',
    displayName: 'Ana',
    email: 'ana@x.co',
    photoUrl: 'https://x/p.png',
  );

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('nothing is stored at first', () async {
    expect(await SharedPreferencesSessionStore().read(), isNull);
  });

  test('a stored user is read back, whole', () async {
    await SharedPreferencesSessionStore().write(user);

    expect(await SharedPreferencesSessionStore().read(), user);
  });

  test('writing null forgets the session', () async {
    final store = SharedPreferencesSessionStore();
    await store.write(user);
    await store.write(null);

    expect(await store.read(), isNull);
  });

  test('optional fields may be missing', () async {
    final store = SharedPreferencesSessionStore();
    await store.write(const AuthUser(uid: 'u2'));

    expect(await store.read(), const AuthUser(uid: 'u2'));
  });
}
