import 'package:fino/core/emulators/emulator_config.dart';
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

/// [testFlavorConfig] running against the local emulators.
final testEmulatedFlavorConfig = FlavorConfig(
  flavor: testFlavorConfig.flavor,
  appName: testFlavorConfig.appName,
  firebaseOptions: testFlavorConfig.firebaseOptions,
  googleServerClientId: testFlavorConfig.googleServerClientId,
  deepLinkHost: testFlavorConfig.deepLinkHost,
  verboseLogging: false,
  analyticsEnabled: false,
  strictConfiguration: false,
  emulators: const EmulatorConfig(authPort: 9099, firestorePort: 8085),
);

/// [testEmulatedFlavorConfig] that also starts a demo session.
final testDemoFlavorConfig = FlavorConfig(
  flavor: testFlavorConfig.flavor,
  appName: testFlavorConfig.appName,
  firebaseOptions: testFlavorConfig.firebaseOptions,
  googleServerClientId: testFlavorConfig.googleServerClientId,
  deepLinkHost: testFlavorConfig.deepLinkHost,
  verboseLogging: false,
  analyticsEnabled: false,
  strictConfiguration: false,
  emulators: const EmulatorConfig(authPort: 9099, firestorePort: 8085),
  demoSession: true,
);
