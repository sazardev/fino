import 'package:flutter/foundation.dart';

/// Whether Firebase Crashlytics exists here: Android, iOS and macOS only.
bool get crashReportingSupported =>
    !kIsWeb &&
    switch (defaultTargetPlatform) {
      TargetPlatform.android ||
      TargetPlatform.iOS ||
      TargetPlatform.macOS => true,
      _ => false,
    };
