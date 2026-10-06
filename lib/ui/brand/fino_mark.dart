import 'package:flutter/material.dart';

import 'fino_mark_painter.dart';

/// The Fino logo: a hand-inked "F". [progress] (0..1) writes it stroke by
/// stroke (cap, stem, crossbar) with short brush lifts between them, then an
/// ink drop closes the stem's curl. At 1 it is the final logo. Ink follows the
/// accent.
class FinoMark extends StatelessWidget {
  const new({required this.progress, super.key, this.size = 160, this.color});

  final Animation<double> progress;
  final double size;

  /// The ink; defaults to the theme's primary.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: 'Fino',
      child: ExcludeSemantics(
        child: RepaintBoundary(
          child: CustomPaint(
            size: Size.square(size),
            painter: FinoMarkPainter(
              progress: progress,
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
