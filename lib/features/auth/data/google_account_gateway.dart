/// The device's Google account chooser, behind an interface so the sign-in
/// logic can be tested without the plugin.
abstract interface class GoogleAccountGateway {
  /// Shows the account chooser; returns the account's ID token.
  Future<String?> authenticate();

  Future<void> signOut();
}
