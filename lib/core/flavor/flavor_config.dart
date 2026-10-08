import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../emulators/emulator_config.dart';
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
    this.appCheckEnabled = false,
    this.emulators,
    this.demoSession = false,
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

  /// Activate App Check (Play Integrity on Android) before backend calls.
  final bool appCheckEnabled;

  /// Run against the local Firebase emulators instead of a real project.
  final EmulatorConfig? emulators;

  /// Start already signed in as a made-up person, with sample data in the
  /// local database, so every screen has something to show. Only meaningful
  /// with [emulators]: it signs in with a fake Google identity.
  final bool demoSession;
}
