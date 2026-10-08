import '../../firebase/options/firebase_options_qa.dart';
import '../flavor.dart';
import '../flavor_config.dart';

/// Testing: test data, verbose logs, analytics collection on.
final qaFlavorConfig = FlavorConfig(
  flavor: Flavor.qa,
  appName: 'Fino QA',
  firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  googleServerClientId:
      '606338504346-n0rousf85k3cgimbuue50t532d4l064v'
      '.apps.googleusercontent.com',
  deepLinkHost: 'qa.fino.example',
  verboseLogging: true,
  analyticsEnabled: true,
  strictConfiguration: false,
  appCheckEnabled: true,
);
