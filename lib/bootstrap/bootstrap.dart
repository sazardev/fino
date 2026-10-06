import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import '../app/app_provider_overrides.dart';
import '../app/fino_app.dart';
import '../app/settings/app_settings.dart';
import '../app/settings/app_settings_provider.dart';
import '../core/flavor/flavor_config.dart';
import '../core/flavor/flavor_config_provider.dart';
import '../core/haptics/haptics_binding.dart';
import '../core/logging/app_logger.dart';
import 'bootstrap_failure_app.dart';
import 'initialize_firebase.dart';
import 'install_error_handlers.dart';
import 'sign_in_demo_user.dart';
import 'start_deferred_services.dart';
import 'start_sync.dart';

/// The one place the app starts, whatever the flavor: errors → Firebase and
/// settings in parallel → the demo person (demo session only) → the app →
/// deferred services after the first frame.
/// If any step fails, a [BootstrapFailureApp] says why.
Future<void> bootstrap(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  final logger = AppLogger(verbose: config.verboseLogging);
  installErrorHandlers(logger);

  try {
    await _start(config, logger);
  } on Object catch (error, stackTrace) {
    logger.error('Startup failed', error, stackTrace);
    runApp(BootstrapFailureApp(error: error));
  }
}

Future<void> _start(FlavorConfig config, AppLogger logger) async {
  usePathUrlStrategy();

  final (_, settings) = await (
    initializeFirebase(config, logger),
    AppSettings.load(),
  ).wait;
  bindHaptics(settings.hapticsEnabled);

  final container = ProviderContainer(
    overrides: [
      flavorConfigProvider.overrideWithValue(config),
      appSettingsProvider.overrideWithValue(settings),
      ...appProviderOverrides(),
    ],
  );
  await signInDemoUser(container, logger);
  startSync(container);
  runApp(
    UncontrolledProviderScope(container: container, child: const FinoApp()),
  );

  WidgetsBinding.instance.addPostFrameCallback(
    (_) => unawaited(startDeferredServices(container)),
  );
}
