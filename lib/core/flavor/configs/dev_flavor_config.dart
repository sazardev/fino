import '../../firebase/options/firebase_options_dev.dart';
import '../flavor.dart';
import '../flavor_config.dart';

/// Daily development: verbose logs, analytics collection off.
final devFlavorConfig = FlavorConfig(
  flavor: Flavor.dev,
  appName: 'Fino Dev',
  firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  googleServerClientId: 'REPLACE_ME',
  deepLinkHost: 'dev.fino.example',
  verboseLogging: true,
  analyticsEnabled: false,
  strictConfiguration: false,
);
