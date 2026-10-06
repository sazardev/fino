// Replaced by `tool/configure_firebase.sh dev` (FlutterFire CLI output).
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options_x.dart';

/// Firebase options of the `fino-dev` project.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => kIsWeb ? web : android;

  static const web = FirebaseOptions(
    apiKey: FirebaseOptionsX.placeholder,
    appId: FirebaseOptionsX.placeholder,
    messagingSenderId: FirebaseOptionsX.placeholder,
    projectId: 'fino-dev',
  );

  static const android = FirebaseOptions(
    apiKey: FirebaseOptionsX.placeholder,
    appId: FirebaseOptionsX.placeholder,
    messagingSenderId: FirebaseOptionsX.placeholder,
    projectId: 'fino-dev',
  );
}
