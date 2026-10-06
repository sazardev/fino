import 'package:firebase_auth/firebase_auth.dart';

import 'google_sign_in_strategy.dart';

/// Web: Firebase's own Google popup.
class WebGoogleSignIn implements GoogleSignInStrategy {
  @override
  Future<void> signIn(FirebaseAuth auth) =>
      auth.signInWithPopup(GoogleAuthProvider());

  @override
  Future<void> signOut() async {}
}
