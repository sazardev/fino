import 'package:flutter/foundation.dart';

/// Whether App Check attestation exists here: Play Integrity, Android only.
bool get appCheckSupported =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
