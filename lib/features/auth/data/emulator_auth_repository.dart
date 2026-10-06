import 'dart:async';

import '../../../core/emulators/emulator_config.dart';
import '../../../core/http/json_post.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';
import 'fake_google_identity.dart';
import 'session_store.dart';

/// Auth against the Firebase Auth emulator over REST, for Linux, where the
/// FlutterFire plugins do not exist. It signs in with a [FakeGoogleIdentity],
/// so it only works against the emulator.
class EmulatorAuthRepository implements AuthRepository {
  new({
    required this._emulators,
    required this._post,
    required this._store,
    this._identity = const FakeGoogleIdentity(),
  });

  // Any key works against the emulator.
  static const _apiKey = 'demo-api-key';

  final EmulatorConfig _emulators;
  final JsonPost _post;
  final SessionStore _store;
  final FakeGoogleIdentity _identity;

  final _changes = StreamController<AuthUser?>.broadcast();
  late final Future<void> _restored = _restore();
  AuthUser? _current;

  Future<void> _restore() async => _current = await _store.read();

  @override
  Stream<AuthUser?> watchUser() async* {
    await _restored;
    yield _current;
    yield* _changes.stream;
  }

  @override
  Future<void> signInWithGoogle() async {
    final response = await _post(
      Uri.http(
        '${_emulators.host}:${_emulators.authPort}',
        '/identitytoolkit.googleapis.com/v1/accounts:signInWithIdp',
        {'key': _apiKey},
      ),
      {
        'requestUri': 'http://localhost',
        'postBody':
            'id_token=${Uri.encodeComponent(_identity.idToken)}'
            '&providerId=google.com',
        'returnSecureToken': true,
        'returnIdpCredential': true,
      },
    );
    await _set(
      AuthUser(
        uid: response['localId']! as String,
        displayName: response['displayName'] as String?,
        email: response['email'] as String?,
        photoUrl: response['photoUrl'] as String?,
      ),
    );
  }

  @override
  Future<void> signOut() => _set(null);

  Future<void> _set(AuthUser? user) async {
    await _store.write(user);
    _current = user;
    _changes.add(user);
  }
}
