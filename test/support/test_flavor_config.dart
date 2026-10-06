import 'package:fino/core/flavor/flavor.dart';
import 'package:fino/core/flavor/flavor_config.dart';
import 'package:firebase_core/firebase_core.dart';

/// A dev-like config that never touches Firebase.
const testFlavorConfig = FlavorConfig(
  flavor: Flavor.dev,
  appName: 'Fino Test',
  firebaseOptions: FirebaseOptions(
    apiKey: 'test',
    appId: 'test',
    messagingSenderId: 'test',
    projectId: 'fino-test',
  ),
  googleServerClientId: 'test',
  deepLinkHost: 'test.fino.example',
  verboseLogging: false,
  analyticsEnabled: false,
  strictConfiguration: false,
);
