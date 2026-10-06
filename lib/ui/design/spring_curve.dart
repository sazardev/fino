import 'dart:math' as math;

import 'package:flutter/animation.dart';

/// A closed-form, duration-agnostic spring curve (damped harmonic
/// oscillator). `t` is a 0..1 fraction of whatever [Duration] the caller
/// assigns, like any other [Curve].
///
/// Safe in `AnimatedContainer`, `TweenAnimationBuilder` and
/// `CurvedAnimation`. NOT safe as the `curve:` of `animateTo()` on a bounded
/// controller: the controller clamps the overshoot flat. Drive it through a
/// `CurvedAnimation` instead.
class SpringCurve extends Curve {
  const SpringCurve({
    this.mass = 1.0,
    this.stiffness = 200.0,
    this.damping = 10.0,
  }) : assert(mass > 0),
       assert(stiffness > 0),
       assert(damping >= 0);

  final double mass;
  final double stiffness;
  final double damping;

  static const SpringCurve bouncy = SpringCurve(
    mass: 0.5,
    stiffness: 300,
    damping: 8,
  );
  static const SpringCurve snappy = SpringCurve(
    mass: 1.0,
    stiffness: 400,
    damping: 18,
  );
  static const SpringCurve gentle = SpringCurve(
    mass: 2.0,
    stiffness: 150,
    damping: 20,
  );

  @override
  double transformInternal(double t) {
    final omegaN = math.sqrt(stiffness / mass);
    final zeta = damping / (2 * math.sqrt(stiffness * mass));
    final decay = math.exp(-zeta * omegaN * t);

    if (zeta >= 1.0) return 1 - decay * (1 + omegaN * t);

    final omegaD = omegaN * math.sqrt(1 - zeta * zeta);
    final osc =
        math.cos(omegaD * t) + (zeta * omegaN / omegaD) * math.sin(omegaD * t);
    return 1 - decay * osc;
  }
}
