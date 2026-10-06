import 'package:fino/features/auth/data/auth_user_mapper.dart';
import 'package:fino/features/auth/data/firebase_auth_repository.dart';
import 'package:fino/features/auth/data/google_account_gateway.dart';
import 'package:fino/features/auth/data/google_sign_in_strategy.dart';
import 'package:fino/features/auth/data/native_google_sign_in.dart';
import 'package:fino/features/auth/data/web_google_sign_in.dart';
import 'package:fino/features/auth/domain/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuth extends Mock implements FirebaseAuth;

class _MockUser extends Mock implements User;

class _MockAccounts extends Mock implements GoogleAccountGateway;

class _MockStrategy extends Mock implements GoogleSignInStrategy;

class _FakeCredential extends Fake implements AuthCredential;

class _FakeProvider extends Fake implements AuthProvider;

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeCredential());
    registerFallbackValue(_FakeProvider());
  });

  test('a Firebase user maps to the app user', () {
    final user = _MockUser();
    when(() => user.uid).thenReturn('u1');
    when(() => user.displayName).thenReturn('Ana');
    when(() => user.email).thenReturn('ana@x.co');
    when(() => user.photoURL).thenReturn('https://x/p.png');

    expect(
      user.toAuthUser(),
      const AuthUser(
        uid: 'u1',
        displayName: 'Ana',
        email: 'ana@x.co',
        photoUrl: 'https://x/p.png',
      ),
    );
  });

  group('FirebaseAuthRepository', () {
    late _MockAuth auth;
    late _MockStrategy strategy;
    late FirebaseAuthRepository repository;

    setUp(() {
      auth = _MockAuth();
      strategy = _MockStrategy();
      repository = FirebaseAuthRepository(auth: auth, googleSignIn: strategy);
    });

    test('watchUser maps sessions and sign-outs', () {
      final user = _MockUser();
      when(() => user.uid).thenReturn('u1');
      when(() => user.displayName).thenReturn(null);
      when(() => user.email).thenReturn(null);
      when(() => user.photoURL).thenReturn(null);
      when(() => auth.authStateChanges())
          .thenAnswer((_) => Stream.fromIterable([user, null]));

      expect(
        repository.watchUser(),
        emitsInOrder([const AuthUser(uid: 'u1'), null, emitsDone]),
      );
    });

    test('signing in delegates to the platform strategy', () async {
      when(() => strategy.signIn(auth)).thenAnswer((_) async {});

      await repository.signInWithGoogle();

      verify(() => strategy.signIn(auth)).called(1);
    });

    test('signing out clears Google, then Firebase', () async {
      when(() => strategy.signOut()).thenAnswer((_) async {});
      when(() => auth.signOut()).thenAnswer((_) async {});

      await repository.signOut();

      verifyInOrder([() => strategy.signOut(), () => auth.signOut()]);
    });
  });

  group('NativeGoogleSignIn', () {
    test('exchanges the Google ID token for a Firebase credential', () async {
      final auth = _MockAuth();
      final accounts = _MockAccounts();
      when(accounts.authenticate).thenAnswer((_) async => 'id-token');
      when(() => auth.signInWithCredential(any()))
          .thenThrow(StateError('stop here'));

      await expectLater(
        NativeGoogleSignIn(accounts).signIn(auth),
        throwsStateError,
      );

      final credential =
          verify(() => auth.signInWithCredential(captureAny())).captured.single
              as OAuthCredential;
      expect(credential.providerId, 'google.com');
      expect(credential.idToken, 'id-token');
    });

    test('signing out forgets the Google account', () async {
      final accounts = _MockAccounts();
      when(accounts.signOut).thenAnswer((_) async {});

      await NativeGoogleSignIn(accounts).signOut();

      verify(accounts.signOut).called(1);
    });
  });

  group('WebGoogleSignIn', () {
    test('opens the Firebase Google popup', () async {
      final auth = _MockAuth();
      when(() => auth.signInWithPopup(any()))
          .thenAnswer((_) => Future.error(StateError('stop')));

      await expectLater(WebGoogleSignIn().signIn(auth), throwsStateError);

      final provider = verify(() => auth.signInWithPopup(captureAny()))
          .captured
          .single;
      expect(provider, isA<GoogleAuthProvider>());
    });

    test('has no Google account to forget', () async {
      await expectLater(WebGoogleSignIn().signOut(), completes);
    });
  });
}
