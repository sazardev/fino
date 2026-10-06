import 'package:flutter/services.dart';

import 'haptic_engine.dart';

/// [HapticEngine] backed by the platform's `HapticFeedback`.
class SystemHapticEngine implements HapticEngine {
  const new();

  @override
  void light() => HapticFeedback.lightImpact();

  @override
  void medium() => HapticFeedback.mediumImpact();

  @override
  void heavy() => HapticFeedback.heavyImpact();

  @override
  void selection() => HapticFeedback.selectionClick();
}
