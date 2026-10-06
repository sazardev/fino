import '../domain/auth_user.dart';

/// Remembers the signed-in user across app restarts, where Firebase's own
/// persistence is not available.
abstract interface class SessionStore {
  Future<AuthUser?> read();

  /// Stores [user], or forgets the session when `null`.
  Future<void> write(AuthUser? user);
}
