import '../../firebase/options/firebase_options_qa.dart';
import '../flavor.dart';
import '../flavor_config.dart';

/// Testing: test data, verbose logs, analytics collection on.
final qaFlavorConfig = FlavorConfig(
  flavor: Flavor.qa,
  appName: 'Fino QA',
  firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  googleServerClientId: 'REPLACE_ME',
  deepLinkHost: 'qa.fino.example',
  verboseLogging: true,
  analyticsEnabled: true,
  strictConfiguration: false,
);
