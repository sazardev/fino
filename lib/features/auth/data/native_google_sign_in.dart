import 'package:firebase_auth/firebase_auth.dart';

import 'google_account_gateway.dart';
import 'google_sign_in_strategy.dart';

/// Android: the system account chooser, exchanged for a Firebase credential.
class NativeGoogleSignIn implements GoogleSignInStrategy {
  new(this._accounts);

  final GoogleAccountGateway _accounts;

  @override
  Future<void> signIn(FirebaseAuth auth) async {
    final idToken = await _accounts.authenticate();
    await auth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: idToken),
    );
  }

  @override
  Future<void> signOut() => _accounts.signOut();
}
