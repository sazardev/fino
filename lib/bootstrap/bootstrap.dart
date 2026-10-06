import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import '../app/fino_app.dart';
import '../app/settings/app_settings.dart';
import '../app/settings/app_settings_provider.dart';
import '../core/flavor/flavor_config.dart';
import '../core/flavor/flavor_config_provider.dart';
import '../core/haptics/haptics_binding.dart';
import '../core/logging/app_logger.dart';
import 'initialize_firebase.dart';
import 'install_error_handlers.dart';
import 'start_deferred_services.dart';

/// The one place the app starts, whatever the flavor: errors → Firebase and
/// settings in parallel → the app → deferred services after the first frame.
Future<void> bootstrap(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  final logger = AppLogger(verbose: config.verboseLogging);
  installErrorHandlers(logger);

  final (_, settings) = await (
    initializeFirebase(config, logger),
    AppSettings.load(),
  ).wait;
  bindHaptics(settings.hapticsEnabled);

  final container = ProviderContainer(
    overrides: [
      flavorConfigProvider.overrideWithValue(config),
      appSettingsProvider.overrideWithValue(settings),
    ],
  );
  runApp(
    UncontrolledProviderScope(container: container, child: const FinoApp()),
  );

  WidgetsBinding.instance.addPostFrameCallback(
    (_) => unawaited(startDeferredServices(container)),
  );
}
