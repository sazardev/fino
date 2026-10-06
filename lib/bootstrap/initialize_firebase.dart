import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../core/firebase/options/firebase_options_x.dart';
import '../core/flavor/flavor_config.dart';
import '../core/logging/app_logger.dart';
import '../core/platform/firebase_plugins_supported.dart';
import 'connect_firebase_emulators.dart';

/// Starts Firebase with the flavor's project (or its emulators).
///
/// Linux has no FlutterFire plugins: there only an emulated flavor runs, and
/// it talks to the Auth emulator over REST (nothing to start here).
/// Drift is the offline source of truth, so Firestore's own cache is off.
Future<void> initializeFirebase(FlavorConfig config, AppLogger logger) async {
  final emulators = config.emulators;

  if (!firebasePluginsSupported) {
    if (emulators == null) {
      throw UnsupportedError(
        '${config.appName}: Firebase has no Linux support, so only an '
        'emulated flavor (dev) can run there.',
      );
    }
    logger.info('Linux: no Firebase plugins, using the emulators over REST.');
    return;
  }

  if (emulators == null) _requireConfigured(config, logger);

  await Firebase.initializeApp(options: config.firebaseOptions);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );
  if (emulators != null) await connectFirebaseEmulators(emulators);
}

void _requireConfigured(FlavorConfig config, AppLogger logger) {
  final unconfigured =
      config.firebaseOptions.isPlaceholder ||
      config.googleServerClientId == FirebaseOptionsX.placeholder;
  if (!unconfigured) return;

  final message =
      '${config.appName}: Firebase is not configured. '
      'Run tool/configure_firebase.sh.';
  if (config.strictConfiguration) throw StateError(message);
  logger.warning(message);
}
