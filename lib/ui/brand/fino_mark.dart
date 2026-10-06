import 'package:flutter/material.dart';

import '../design/app_curves.dart';
import 'fino_mark_painter.dart';

/// The Fino logo. [progress] (0..1) plays the build: the dial sketches itself,
/// the coin pops into the opening, then the "equals" bars draw across. At 1 it
/// is the final logo. Colors follow the accent.
class FinoMark extends StatelessWidget {
  const FinoMark({
    super.key,
    required this.progress,
    this.size = 160,
    this.color,
    this.tint,
  });

  final Animation<double> progress;
  final double size;

  /// The ring; defaults to the theme's primary.
  final Color? color;

  /// The bars and coin; defaults to a lighter tone of [color].
  final Color? tint;

  static const _ring = Interval(0.0, 0.55, curve: Curves.easeInOutCubic);
  static const _track = Interval(0.0, 0.2, curve: Curves.easeOut);
  static const _trackOut = Interval(0.45, 0.6);
  static const _coin = Interval(0.42, 0.7, curve: AppCurves.bouncy);
  static const _bars = Interval(0.6, 0.92, curve: Curves.easeOutCubic);

  @override
  Widget build(BuildContext context) {
    final base = color ?? Theme.of(context).colorScheme.primary;
    final light = tint ?? Color.lerp(base, Colors.white, 0.55)!;

    return Semantics(
      image: true,
      label: 'Fino',
      child: ExcludeSemantics(
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: progress,
            builder: (context, _) {
              final t = progress.value;
              return CustomPaint(
                size: Size.square(size),
                painter: FinoMarkPainter(
                  ring: _ring.transform(t),
                  track: _track.transform(t) * (1 - _trackOut.transform(t)),
                  coin: _coin.transform(t),
                  bars: _bars.transform(t),
                  color: base,
                  tint: light,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
