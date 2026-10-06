import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'flavor.dart';

/// Everything that differs between dev, qa and prod.
///
/// The only place environment differences live: code reads a field from here,
/// it never compares flavors or checks `kDebugMode`.
@immutable
class FlavorConfig {
  const new({
    required this.flavor,
    required this.appName,
    required this.firebaseOptions,
    required this.googleServerClientId,
    required this.deepLinkHost,
    required this.verboseLogging,
    required this.analyticsEnabled,
    required this.strictConfiguration,
  });

  final Flavor flavor;
  final String appName;
  final FirebaseOptions firebaseOptions;

  /// OAuth *web* client id of the flavor's Firebase project (Google Sign-In).
  final String googleServerClientId;

  /// Host of the flavor's App Links and web URLs.
  final String deepLinkHost;
  final bool verboseLogging;
  final bool analyticsEnabled;

  /// Refuse to start with unconfigured Firebase or Google credentials.
  final bool strictConfiguration;
}
