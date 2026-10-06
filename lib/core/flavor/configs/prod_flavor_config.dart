import '../../firebase/options/firebase_options_prod.dart';
import '../flavor.dart';
import '../flavor_config.dart';

/// Production: quiet logs, analytics collection on.
final prodFlavorConfig = FlavorConfig(
  flavor: Flavor.prod,
  appName: 'Fino',
  firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  googleServerClientId: 'REPLACE_ME',
  deepLinkHost: 'fino.example',
  verboseLogging: false,
  analyticsEnabled: true,
  strictConfiguration: true,
);
