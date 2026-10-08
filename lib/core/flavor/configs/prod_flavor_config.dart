import '../../firebase/options/firebase_options_prod.dart';
import '../flavor.dart';
import '../flavor_config.dart';

/// Production: quiet logs, analytics collection on.
final prodFlavorConfig = FlavorConfig(
  flavor: Flavor.prod,
  appName: 'Fino',
  firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  googleServerClientId:
      '890454769525-ub5n4d39fbc8f9fm11vg1q0flil7he7c'
      '.apps.googleusercontent.com',
  deepLinkHost: 'fino.example',
  verboseLogging: false,
  analyticsEnabled: true,
  strictConfiguration: true,
  appCheckEnabled: true,
);
