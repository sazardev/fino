import 'package:flutter/foundation.dart';

import 'haptics.dart';

/// Keeps `Haptics.enabled` in step with the user's vibration setting.
void bindHaptics(ValueListenable<bool> enabled) {
  Haptics.enabled = enabled.value;
  enabled.addListener(() => Haptics.enabled = enabled.value);
}
