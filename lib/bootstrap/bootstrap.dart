import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import '../app/app_provider_overrides.dart';
import '../app/fino_app.dart';
import '../app/settings/app_settings.dart';
import '../app/settings/app_settings_provider.dart';
import '../core/app_check/app_check_activator_provider.dart';
import '../core/crash_reporting/crash_reporter_provider.dart';
import '../core/crash_reporting/create_crash_reporter.dart';
import '../core/flavor/flavor_config.dart';
import '../core/flavor/flavor_config_provider.dart';
import '../core/haptics/haptics_binding.dart';
import '../core/logging/app_logger.dart';
import '../core/performance/performance_monitor_provider.dart';
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

  final crashReporter = createCrashReporter();
  installErrorHandlers(logger, crashReporter: crashReporter);

  final container = ProviderContainer(
    overrides: [
      flavorConfigProvider.overrideWithValue(config),
      appSettingsProvider.overrideWithValue(settings),
      crashReporterProvider.overrideWithValue(crashReporter),
      ...appProviderOverrides(),
    ],
  );
  final telemetryEnabled = config.analyticsEnabled;
  await crashReporter.setCollectionEnabled(enabled: telemetryEnabled);
  await container
      .read(performanceMonitorProvider)
      .setCollectionEnabled(enabled: telemetryEnabled);
  if (config.appCheckEnabled) await _activateAppCheck(container, logger);

  await signInDemoUser(container, logger);
  startSync(container);
  runApp(
    UncontrolledProviderScope(container: container, child: const FinoApp()),
  );

  WidgetsBinding.instance.addPostFrameCallback(
    (_) => unawaited(startDeferredServices(container)),
  );
}

Future<void> _activateAppCheck(
  ProviderContainer container,
  AppLogger logger,
) async {
  try {
    await container.read(appCheckActivatorProvider).activate();
  } on Object catch (error, stackTrace) {
    logger
      ..warning('App Check could not activate: $error')
      ..debug('$stackTrace');
  }
}
