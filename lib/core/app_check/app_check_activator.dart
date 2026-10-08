/// Activates Firebase App Check, so backend calls carry an attestation token.
abstract interface class AppCheckActivator {
  Future<void> activate();
}
