import 'package:flutter/animation.dart';

import 'spring_curve.dart';

/// Shared motion curves: three springs plus the standard easings.
abstract final class AppCurves {
  const new _();

  /// Playful overshoot (~34 %): taps, pops, celebrations.
  static const SpringCurve bouncy = SpringCurve.bouncy;

  /// Quick settle (~21 %): general UI motion.
  static const SpringCurve snappy = SpringCurve.snappy;

  /// Slow, subtle (~11 %): sheets, cards, page transitions.
  static const SpringCurve gentle = SpringCurve.gentle;

  /// State changes such as selection fills.
  static const Curve select = Curves.easeOut;

  /// Size and layout changes (`AnimatedSize`).
  static const Curve settle = Curves.easeOutCubic;

  /// Icon swaps.
  static const Curve emphasized = Curves.easeOutBack;
}
