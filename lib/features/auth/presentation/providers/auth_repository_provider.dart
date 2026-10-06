import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/firebase/firebase_auth_provider.dart';
import '../../../../core/flavor/flavor_config_provider.dart';
import '../../../../core/http/io_json_post.dart';
import '../../../../core/platform/firebase_plugins_supported_provider.dart';
import '../../data/emulator_auth_repository.dart';
import '../../data/firebase_auth_repository.dart';
import '../../data/shared_preferences_session_store.dart';
import '../../domain/auth_repository.dart';
import 'google_sign_in_strategy_provider.dart';

part 'auth_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  if (ref.watch(firebasePluginsSupportedFlagProvider)) {
    return FirebaseAuthRepository(
      auth: ref.watch(firebaseAuthProvider),
      googleSignIn: ref.watch(googleSignInStrategyProvider),
    );
  }
  final emulators = ref.watch(flavorConfigProvider).emulators;
  if (emulators == null) {
    throw StateError('Without Firebase plugins only emulated flavors run.');
  }
  return EmulatorAuthRepository(
    emulators: emulators,
    post: ioJsonPost,
    store: SharedPreferencesSessionStore(),
  );
}
