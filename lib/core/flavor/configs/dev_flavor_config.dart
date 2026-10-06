import '../../emulators/emulator_config.dart';
import '../../firebase/options/firebase_options_dev.dart';
import '../flavor.dart';
import '../flavor_config.dart';

/// Daily development: verbose logs, analytics off, Firebase emulated, and a
/// demo person with sample data already signed in.
final devFlavorConfig = FlavorConfig(
  flavor: Flavor.dev,
  appName: 'Fino Dev',
  firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  googleServerClientId: 'emulator',
  deepLinkHost: 'dev.fino.example',
  verboseLogging: true,
  analyticsEnabled: false,
  strictConfiguration: false,
  emulators: const EmulatorConfig(authPort: 9099, firestorePort: 8085),
  demoSession: true,
);
