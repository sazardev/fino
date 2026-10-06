import 'package:fino/app/router/auth_redirect.dart';
import 'package:fino/features/auth/domain/auth_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';

void main() {
  const signedOut = AsyncData<AuthUser?>(null);
  const signedIn = AsyncData<AuthUser?>(testUser);

  test('waits for Firebase before deciding', () {
    expect(
      authRedirect(auth: const AsyncLoading(), location: Uri.parse('/ajustes')),
      isNull,
    );
  });

  test('signed out goes to sign-in, remembering where it was headed', () {
    expect(
      authRedirect(auth: signedOut, location: Uri.parse('/ajustes')),
      '/iniciar-sesion?from=%2Fajustes',
    );
  });

  test('signed out at home needs no "from"', () {
    expect(
      authRedirect(auth: signedOut, location: Uri.parse('/')),
      '/iniciar-sesion',
    );
  });

  test('signed out may stay on sign-in', () {
    expect(
      authRedirect(auth: signedOut, location: Uri.parse('/iniciar-sesion')),
      isNull,
    );
  });

  test('a failed session is treated as signed out', () {
    expect(
      authRedirect(
        auth: const AsyncError<AuthUser?>('boom', StackTrace.empty),
        location: Uri.parse('/'),
      ),
      '/iniciar-sesion',
    );
  });

  test('signed in leaves sign-in for where it was headed', () {
    expect(
      authRedirect(
        auth: signedIn,
        location: Uri.parse('/iniciar-sesion?from=%2Fajustes'),
      ),
      '/ajustes',
    );
  });

  test('signed in never follows an off-app "from"', () {
    expect(
      authRedirect(
        auth: signedIn,
        location: Uri.parse('/iniciar-sesion?from=%2F%2Fevil.com'),
      ),
      '/',
    );
  });

  test('signed in passes everywhere else', () {
    expect(
      authRedirect(auth: signedIn, location: Uri.parse('/ajustes')),
      isNull,
    );
  });
}
