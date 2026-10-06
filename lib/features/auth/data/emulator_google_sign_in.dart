import 'package:firebase_auth/firebase_auth.dart';

import 'fake_google_identity.dart';
import 'google_sign_in_strategy.dart';

/// Development: signs in as a fake Google account against the Auth emulator,
/// on platforms that have the FlutterFire plugins.
class EmulatorGoogleSignIn implements GoogleSignInStrategy {
  const new([this._identity = const FakeGoogleIdentity()]);

  final FakeGoogleIdentity _identity;

  @override
  Future<void> signIn(FirebaseAuth auth) => auth.signInWithCredential(
    GoogleAuthProvider.credential(idToken: _identity.idToken),
  );

  @override
  Future<void> signOut() async {}
}
