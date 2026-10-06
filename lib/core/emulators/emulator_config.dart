import 'package:flutter/foundation.dart';

/// Where the local Firebase Emulator Suite listens (see `firebase.json`).
@immutable
class EmulatorConfig {
  const new({required this.authPort, required this.firestorePort});

  final int authPort;
  final int firestorePort;

  /// The host as the running build sees it: the Android emulator reaches the
  /// computer at 10.0.2.2; everything else uses `localhost` (a physical phone
  /// needs `adb reverse` for each port).
  String get host => !kIsWeb && defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2'
      : 'localhost';
}
