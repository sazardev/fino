import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routing/in_app_location.dart';
import '../../features/auth/domain/auth_user.dart';
import 'app_routes.dart';

/// Where the auth guard sends [location], or `null` to let it through.
///
/// Signed out → the sign-in screen (remembering where they were going).
/// Signed in on the sign-in screen → where they were going, or home.
/// Nothing is decided until Firebase has answered.
String? authRedirect({
  required AsyncValue<AuthUser?> auth,
  required Uri location,
}) {
  if (auth.isLoading && !auth.hasValue) return null;

  final signedIn = auth.value != null;
  final onSignIn = location.path == signInPath;

  if (!signedIn && !onSignIn) {
    final from = location.toString();
    return SignInRoute(from: from == '/' ? null : from).location;
  }
  if (signedIn && onSignIn) {
    return inAppLocationOrNull(location.queryParameters['from']) ?? '/';
  }
  return null;
}
