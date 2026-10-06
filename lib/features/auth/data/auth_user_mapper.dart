import 'package:firebase_auth/firebase_auth.dart';

import '../domain/auth_user.dart';

extension UserToAuthUser on User {
  AuthUser toAuthUser() => AuthUser(
    uid: uid,
    displayName: displayName,
    email: email,
    photoUrl: photoURL,
  );
}
