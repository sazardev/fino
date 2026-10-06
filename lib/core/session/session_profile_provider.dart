import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'session_profile.dart';

part 'session_profile_provider.g.dart';

/// El perfil de quien está en sesión (`null` = nadie). La app lo sobrescribe
/// con el estado de autenticación.
@Riverpod(keepAlive: true)
SessionProfile? sessionProfile(Ref ref) => null;
