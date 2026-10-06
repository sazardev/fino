import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/flavor/flavor_config_provider.dart';
import '../../data/emulator_google_sign_in.dart';
import '../../data/google_sign_in_strategy.dart';
import '../../data/native_google_sign_in.dart';
import '../../data/plugin_google_account_gateway.dart';
import '../../data/web_google_sign_in.dart';

part 'google_sign_in_strategy_provider.g.dart';

@Riverpod(keepAlive: true)
GoogleSignInStrategy googleSignInStrategy(Ref ref) {
  final config = ref.watch(flavorConfigProvider);
  if (config.emulators != null) return const EmulatorGoogleSignIn();
  if (kIsWeb) return WebGoogleSignIn();
  return NativeGoogleSignIn(
    PluginGoogleAccountGateway(serverClientId: config.googleServerClientId),
  );
}
