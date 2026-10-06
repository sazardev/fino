import 'package:flutter/widgets.dart';

extension ReducedMotion on BuildContext {
  /// True when the user asked the system to reduce animations.
  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);
}
