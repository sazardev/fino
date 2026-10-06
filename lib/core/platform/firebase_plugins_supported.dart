import 'package:flutter/foundation.dart';

/// Whether the FlutterFire plugins exist on this platform. They do not on
/// Linux, where the app talks to the emulators over REST instead.
bool get firebasePluginsSupported =>
    kIsWeb || defaultTargetPlatform != TargetPlatform.linux;
