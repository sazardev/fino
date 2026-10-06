import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Draws the Fino mark: a copperplate "F" written with a pointed pen. Upstrokes
/// and sideways strokes are hairlines; downstrokes swell as if the nib opened
/// under pressure. Three strokes (cap, stem, crossbar) and an ink drop that
/// closes the stem's curl.
///
/// [strokes] holds one progress (0..1) per stroke; [drop] may overshoot.
class FinoMarkPainter extends CustomPainter {
  new({required this.strokes, required this.drop, required this.color})
    : assert(strokes.length == strokeCount, 'One progress per stroke');

  final List<double> strokes;
  final double drop;
  final Color color;

  static const strokeCount = 3;

  /// The glyph is laid out in a 100 × 100 box.
  static const _box = 100.0;
  static const _hair = 2.4;
  static const _swell = 10.5;
  static const _dropRadius = 4.6;
  static const _samples = 320;

  static final List<_Stroke> _glyph = [
    // Cap: a hooked entry, a wave across the top, a falling teardrop tail.
    _Stroke(
      Path()
        ..moveTo(14, 31)
        ..cubicTo(13, 21, 25, 16, 36, 21)
        ..cubicTo(47, 26, 58, 27, 70, 21)
        ..cubicTo(82, 15.5, 91, 15, 93.5, 24),
      endTaper: 0.5,
    ),
    // Stem: the long downstroke, then a curl back to the left.
    _Stroke(
      Path()
        ..moveTo(62, 23)
        ..cubicTo(58, 40, 56, 58, 48, 74)
        ..cubicTo(42, 86, 30, 92, 22, 86.5)
        ..cubicTo(16.5, 82, 19.5, 73.5, 28, 75.5),
      endTaper: 0.55,
    ),
    // Crossbar: a short wave through the stem.
    _Stroke(
      Path()
        ..moveTo(38, 57)
        ..cubicTo(44, 51.5, 51, 52, 57, 54)
        ..cubicTo(62, 55.5, 67, 54.5, 72, 50),
      endTaper: 0.3,
    ),
  ];

  /// Where the ink drop lands: the end of the stem's curl.
  static Offset get _dropAt => _glyph[1].points.last;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.shortestSide / _box;
    canvas
      ..translate(
        (size.width - size.shortestSide) / 2,
        (size.height - size.shortestSide) / 2,
      )
      ..scale(scale);

    final ink = Paint()
      ..color = color
      ..isAntiAlias = true;
    // A faint, soft copy underneath reads as ink bleeding into the paper.
    final bleed = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.5 / scale + 0.35);

    for (var i = 0; i < strokeCount; i++) {
      final t = strokes[i];
      if (t <= 0) continue;
      final outline = _glyph[i].outline(t);
      canvas
        ..drawPath(outline, bleed)
        ..drawPath(outline, ink);
    }

    if (drop > 0) {
      final r = _dropRadius * drop;
      canvas
        ..drawCircle(_dropAt, r * 1.12, bleed)
        ..drawCircle(_dropAt, r, ink);
    }
  }

  @override
  bool shouldRepaint(FinoMarkPainter old) =>
      drop != old.drop ||
      color != old.color ||
      !_sameStrokes(strokes, old.strokes);

  static bool _sameStrokes(List<double> a, List<double> b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// One pen stroke, pre-sampled once: points along the path and the nib width
/// at each point.
class _Stroke {
  new(Path path, {required double endTaper}) {
    final metric = path.computeMetrics().single;
    const n = FinoMarkPainter._samples;
    final pressure = <double>[];

    for (var i = 0; i <= n; i++) {
      final tangent = metric.getTangentForOffset(metric.length * i / n)!;
      final dir = tangent.vector / tangent.vector.distance;
      points.add(tangent.position);
      // Pointed pen: pressure only on the way down.
      pressure.add(((dir.dy - 0.15) / 0.85).clamp(0.0, 1.0));
    }

    // Smooth the pressure so the swell eases in and out like a real nib.
    const window = 9;
    for (var i = 0; i <= n; i++) {
      var sum = 0.0;
      var count = 0;
      for (var j = i - window; j <= i + window; j++) {
        if (j < 0 || j > n) continue;
        sum += pressure[j];
        count++;
      }
      final p = math.pow(sum / count, 1.4).toDouble();
      final s = i / n;
      final taper = math.min(
        _ramp(s / 0.12, 0.15),
        _ramp((1 - s) / 0.12, endTaper),
      );
      widths.add(
        (FinoMarkPainter._hair +
                (FinoMarkPainter._swell - FinoMarkPainter._hair) * p) *
            taper,
      );
    }
  }

  final points = <Offset>[];
  final widths = <double>[];

  /// Eases from [floor] (at 0) up to 1 (at 1 and beyond).
  static double _ramp(double x, double floor) {
    final t = Curves.easeOut.transform(x.clamp(0.0, 1.0));
    return ui.lerpDouble(floor, 1, t)!;
  }

  /// The filled shape of the first [t] (0..1) of the stroke: the nib's disc
  /// stamped at every sample. Unlike an offset outline, this never folds over
  /// itself on tight curls, however heavy the stroke.
  Path outline(double t) {
    final last = points.length - 1;
    final end = last * t.clamp(0.0, 1.0);
    final whole = end.floor();
    final path = Path();
    for (var i = 0; i <= whole; i++) {
      path.addOval(Rect.fromCircle(center: points[i], radius: widths[i] / 2));
    }
    final frac = end - whole;
    if (frac > 0 && whole < last) {
      path.addOval(
        Rect.fromCircle(
          center: Offset.lerp(points[whole], points[whole + 1], frac)!,
          radius: ui.lerpDouble(widths[whole], widths[whole + 1], frac)! / 2,
        ),
      );
    }
    return path;
  }
}
