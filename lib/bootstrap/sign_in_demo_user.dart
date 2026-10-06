import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/demo/demo_data_provider.dart';
import '../core/flavor/flavor_config_provider.dart';
import '../core/logging/app_logger.dart';
import '../features/auth/presentation/providers/auth_repository_provider.dart';

/// In a demo session, signs in as the fake Google person (unless a session
/// was already restored) and starts keeping the sample data in place. If the
/// emulators are not up it only warns: the person lands on the sign-in screen.
Future<void> signInDemoUser(
  ProviderContainer container,
  AppLogger logger,
) async {
  if (!container.read(flavorConfigProvider).demoSession) return;

  container.read(demoDataProvider);
  final auth = container.read(authRepositoryProvider);
  try {
    const wait = Duration(seconds: 5);
    if (await auth.watchUser().first.timeout(wait) != null) return;
    await auth.signInWithGoogle().timeout(wait);
  } on Object catch (error, stackTrace) {
    logger
      ..warning('Demo sign-in failed (are the emulators running?): $error')
      ..debug('$stackTrace');
  }
}
