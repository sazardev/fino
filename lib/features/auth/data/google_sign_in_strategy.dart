import 'package:firebase_auth/firebase_auth.dart';

/// One way of getting a Google identity into Firebase Auth. The platform
/// decides which implementation runs.
abstract interface class GoogleSignInStrategy {
  Future<void> signIn(FirebaseAuth auth);

  /// Forgets the Google account (Firebase's own sign-out is separate).
  Future<void> signOut();
}
