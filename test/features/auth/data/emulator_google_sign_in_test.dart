import 'package:fino/features/auth/data/emulator_google_sign_in.dart';
import 'package:fino/features/auth/data/fake_google_identity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuth extends Mock implements FirebaseAuth;

class _FakeCredential extends Fake implements AuthCredential;

void main() {
  setUpAll(() => registerFallbackValue(_FakeCredential()));

  test('signs in with the fake identity as a Google credential', () async {
    final auth = _MockAuth();
    when(() => auth.signInWithCredential(any()))
        .thenAnswer((_) => Future.error(StateError('stop here')));

    await expectLater(
      const EmulatorGoogleSignIn().signIn(auth),
      throwsStateError,
    );

    final credential =
        verify(() => auth.signInWithCredential(captureAny())).captured.single
            as OAuthCredential;
    expect(credential.providerId, 'google.com');
    expect(credential.idToken, const FakeGoogleIdentity().idToken);
  });

  test('has no Google account to forget', () async {
    await expectLater(const EmulatorGoogleSignIn().signOut(), completes);
  });
}
