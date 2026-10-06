import 'package:flutter_riverpod/misc.dart';

import '../../core/session/session_profile.dart';
import '../../core/session/session_profile_provider.dart';
import '../../core/session/session_user_id_provider.dart';
import '../../features/auth/presentation/providers/auth_state_provider.dart';

/// Une la sesión de autenticación con lo que leen los features, que no
/// conocen a auth.
List<Override> sessionOverrides() => [
  sessionUserIdProvider.overrideWith(
    (ref) => ref.watch(authStateProvider).value?.uid,
  ),
  sessionProfileProvider.overrideWith((ref) {
    final user = ref.watch(authStateProvider).value;
    if (user == null) return null;
    return SessionProfile(
      uid: user.uid,
      displayName: user.displayName ?? user.email ?? 'Yo',
      photoUrl: user.photoUrl,
    );
  }),
];
