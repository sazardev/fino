import 'package:flutter/material.dart';

import '../design/app_curves.dart';
import 'fino_mark_painter.dart';

/// The Fino logo: a hand-lettered "F" in fine ink. [progress] (0..1) writes
/// it stroke by stroke (cap, stem, crossbar) with short pen lifts between
/// them, then an ink drop closes the stem's curl. At 1 it is the final logo.
/// Ink follows the accent.
class FinoMark extends StatelessWidget {
  const new({required this.progress, super.key, this.size = 160, this.color});

  final Animation<double> progress;
  final double size;

  /// The ink; defaults to the theme's primary.
  final Color? color;

  // A hand slows into and out of each stroke; the gaps are pen lifts.
  static const _strokes = [
    Interval(0, 0.32, curve: Curves.easeInOutSine),
    Interval(0.38, 0.74, curve: Curves.easeInOutCubic),
    Interval(0.8, 0.93, curve: Curves.easeInOutSine),
  ];
  static const _drop = Interval(0.7, 1, curve: AppCurves.bouncy);

  @override
  Widget build(BuildContext context) {
    final ink = color ?? Theme.of(context).colorScheme.primary;

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
                  strokes: [for (final s in _strokes) s.transform(t)],
                  drop: _drop.transform(t),
                  color: ink,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
