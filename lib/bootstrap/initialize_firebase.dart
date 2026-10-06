import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../core/firebase/options/firebase_options_x.dart';
import '../core/flavor/flavor_config.dart';
import '../core/logging/app_logger.dart';

/// Starts Firebase with the flavor's project.
///
/// Drift is the offline source of truth, so Firestore's own cache is off.
Future<void> initializeFirebase(FlavorConfig config, AppLogger logger) async {
  final unconfigured =
      config.firebaseOptions.isPlaceholder ||
      config.googleServerClientId == FirebaseOptionsX.placeholder;
  if (unconfigured) {
    final message =
        '${config.appName}: Firebase is not configured. '
        'Run tool/configure_firebase.sh.';
    if (config.strictConfiguration) throw StateError(message);
    logger.warning(message);
  }

  await Firebase.initializeApp(options: config.firebaseOptions);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );
}
