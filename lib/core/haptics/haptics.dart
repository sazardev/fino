import 'package:flutter/foundation.dart';

import 'haptic_engine.dart';
import 'system_haptic_engine.dart';

/// The app's haptic vocabulary: ask for a named event, never for raw
/// vibration, so the same gesture feels the same everywhere.
///
/// Two phases, like a physical button: press-down is a light [tap]; a
/// decision adds a firmer beat ([confirm], [warning]).
abstract final class Haptics {
  const Haptics._();

  static HapticEngine engine = const SystemHapticEngine();

  /// Master switch (the user's vibration setting).
  static bool enabled = true;

  static final Stopwatch _clock = Stopwatch()..start();
  static int _lastMicroMs = -1000;

  /// Press-down on any control.
  static void tap() => _micro(engine.light);

  /// A choice was made (segment, swatch, card).
  static void select() => _micro(engine.selection);

  /// One notch of a slider or stepper.
  static void tick() => _micro(engine.selection);

  /// A decision: save, start, long press.
  static void confirm() => _fire(engine.medium);

  /// A switch flipped: firmer when turned on.
  static void toggle(bool on) => _fire(on ? engine.medium : engine.light);

  /// A destructive step.
  static void warning() => _fire(engine.heavy);

  /// Something finished well.
  static void success() {
    _fire(engine.medium);
    Future<void>.delayed(const Duration(milliseconds: 90), () {
      if (enabled) engine.light();
    });
  }

  /// Forgets the debounce history, so tests don't leak into each other.
  @visibleForTesting
  static void resetForTest() => _lastMicroMs = -1000;

  /// Tiny events are debounced (22 ms) so a fast drag doesn't smear into a
  /// buzz.
  static void _micro(void Function() event) {
    final now = _clock.elapsedMilliseconds;
    if (now - _lastMicroMs < 22) return;
    _lastMicroMs = now;
    _fire(event);
  }

  static void _fire(void Function() event) {
    if (enabled) event();
  }
}
