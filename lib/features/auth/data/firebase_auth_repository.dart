import 'package:firebase_auth/firebase_auth.dart';

import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';
import 'auth_user_mapper.dart';
import 'google_sign_in_strategy.dart';

class FirebaseAuthRepository implements AuthRepository {
  new({required this._auth, required this._googleSignIn});

  final FirebaseAuth _auth;
  final GoogleSignInStrategy _googleSignIn;

  @override
  Stream<AuthUser?> watchUser() =>
      _auth.authStateChanges().map((user) => user?.toAuthUser());

  @override
  Future<void> signInWithGoogle() => _googleSignIn.signIn(_auth);

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
