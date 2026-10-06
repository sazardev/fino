import 'auth_user.dart';

/// Who is signed in, and how to change that.
abstract interface class AuthRepository {
  /// Emits the current user (or `null`) now and on every change.
  Stream<AuthUser?> watchUser();

  Future<void> signInWithGoogle();

  Future<void> signOut();
}
