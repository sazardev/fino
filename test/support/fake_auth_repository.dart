import 'dart:async';

import 'package:fino/features/auth/domain/auth_repository.dart';
import 'package:fino/features/auth/domain/auth_user.dart';

/// An in-memory session: signing in or out emits like the real thing.
class FakeAuthRepository implements AuthRepository {
  new({this._user});

  AuthUser? _user;
  final _changes = StreamController<AuthUser?>.broadcast();

  /// Make the next sign-in attempt fail.
  Exception? signInError;

  @override
  Stream<AuthUser?> watchUser() async* {
    yield _user;
    yield* _changes.stream;
  }

  @override
  Future<void> signInWithGoogle() async {
    if (signInError case final error?) throw error;
    _set(testUser);
  }

  @override
  Future<void> signOut() async => _set(null);

  void _set(AuthUser? user) {
    _user = user;
    _changes.add(user);
  }
}

const testUser = AuthUser(uid: 'u1', displayName: 'Ana', email: 'ana@x.co');
