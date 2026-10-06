import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/emulators/emulator_config.dart';

/// Points the Firebase SDKs at the local emulators. Must run before they are
/// used.
Future<void> connectFirebaseEmulators(EmulatorConfig emulators) async {
  FirebaseFirestore.instance.useFirestoreEmulator(
    emulators.host,
    emulators.firestorePort,
  );
  await FirebaseAuth.instance.useAuthEmulator(
    emulators.host,
    emulators.authPort,
  );
}
