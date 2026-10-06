import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/firebase/firebase_auth_provider.dart';
import '../../data/firebase_auth_repository.dart';
import '../../domain/auth_repository.dart';
import 'google_sign_in_strategy_provider.dart';

part 'auth_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => FirebaseAuthRepository(
  auth: ref.watch(firebaseAuthProvider),
  googleSignIn: ref.watch(googleSignInStrategyProvider),
);
