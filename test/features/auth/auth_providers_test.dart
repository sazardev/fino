import 'package:fino/core/firebase/firebase_auth_provider.dart';
import 'package:fino/core/flavor/flavor_config_provider.dart';
import 'package:fino/features/auth/data/firebase_auth_repository.dart';
import 'package:fino/features/auth/data/google_sign_in_strategy.dart';
import 'package:fino/features/auth/data/native_google_sign_in.dart';
import 'package:fino/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:fino/features/auth/presentation/providers/google_sign_in_strategy_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../support/test_flavor_config.dart';

class _MockAuth extends Mock implements FirebaseAuth;

class _MockStrategy extends Mock implements GoogleSignInStrategy;

void main() {
  test('off the web, Google sign-in goes through the native strategy', () {
    final container = ProviderContainer(
      overrides: [flavorConfigProvider.overrideWithValue(testFlavorConfig)],
    );
    addTearDown(container.dispose);

    expect(
      container.read(googleSignInStrategyProvider),
      isA<NativeGoogleSignIn>(),
    );
  });

  test('the repository is built from Firebase Auth and the strategy', () {
    final container = ProviderContainer(
      overrides: [
        firebaseAuthProvider.overrideWithValue(_MockAuth()),
        googleSignInStrategyProvider.overrideWithValue(_MockStrategy()),
      ],
    );
    addTearDown(container.dispose);

    expect(
      container.read(authRepositoryProvider),
      isA<FirebaseAuthRepository>(),
    );
  });
}
