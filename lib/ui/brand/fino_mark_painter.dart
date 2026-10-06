import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../design/app_curves.dart';

/// Draws the Fino mark: a hand-inked "F". Upstrokes and sideways strokes stay
/// lean; downstrokes swell as if the brush were pressed. Three strokes (cap,
/// stem, crossbar) and an ink drop that closes the stem's curl.
///
/// [progress] (0..1) plays the timeline and drives repaints directly, so
/// animating it never rebuilds widgets.
class FinoMarkPainter extends CustomPainter {
  new({required this.progress, required this.color}) : super(repaint: progress);

  final Animation<double> progress;
  final Color color;

  // A hand slows into and out of each stroke; the gaps are brush lifts.
  static const _timeline = [
    Interval(0, 0.32, curve: Curves.easeInOutSine),
    Interval(0.38, 0.74, curve: Curves.easeInOutCubic),
    Interval(0.8, 0.93, curve: Curves.easeInOutSine),
  ];
  static const _dropTimeline = Interval(0.7, 1, curve: AppCurves.bouncy);

  /// The glyph is laid out in a 100 × 100 box.
  static const _box = 100.0;
  static const _hair = 3.2;
  static const _swell = 12.5;
  static const _dropRadius = 5.2;
  static const _samples = 320;

  /// Width steps the nib is quantized to; fine enough to look continuous.
  static const _levels = 360;

  static final List<_Stroke> _glyph = [
    // Cap: a hooked entry, a wave across the top, a falling teardrop tail.
    _Stroke(
      Path()
        ..moveTo(14, 31)
        ..cubicTo(13, 21, 25, 16, 36, 21)
        ..cubicTo(47, 26, 58, 27, 70, 21)
        ..cubicTo(82, 15.5, 91, 15, 93.5, 24),
      endTaper: 0.7,
    ),
    // Stem: the long downstroke, then a curl back to the left.
    _Stroke(
      Path()
        ..moveTo(62, 23)
        ..cubicTo(58, 40, 56, 58, 48, 74)
        ..cubicTo(42, 86, 30, 92, 22, 86.5)
        ..cubicTo(16.5, 82, 19.5, 73.5, 28, 75.5),
      endTaper: 0.7,
    ),
    // Crossbar: a short wave through the stem.
    _Stroke(
      Path()
        ..moveTo(38, 57)
        ..cubicTo(44, 51.5, 51, 52, 57, 54)
        ..cubicTo(62, 55.5, 67, 54.5, 72, 50),
      endTaper: 0.55,
    ),
  ];

  /// Where the ink drop lands: the end of the stem's curl.
  static final Offset _dropAt = _glyph[1].points.last;

  /// Builds the glyph ahead of time so the first animated frame doesn't pay
  /// for it.
  static void warmUp() => _glyph;

  final Paint _nib = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  final Paint _fill = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress.value;
    canvas
      ..translate(
        (size.width - size.shortestSide) / 2,
        (size.height - size.shortestSide) / 2,
      )
      ..scale(size.shortestSide / _box);

    _nib.color = color;
    _fill.color = color;

    for (var i = 0; i < _glyph.length; i++) {
      final p = _timeline[i].transform(t);
      if (p > 0) _glyph[i].draw(canvas, p, _nib, _fill);
    }

    final drop = _dropTimeline.transform(t);
    if (drop > 0) canvas.drawCircle(_dropAt, _dropRadius * drop, _fill);
  }

  @override
  bool shouldRepaint(FinoMarkPainter old) =>
      progress != old.progress || color != old.color;
}

/// One brush stroke, pre-sampled once. Samples are grouped by (quantized) nib
/// width so a frame draws each group with a single round-capped
/// `drawRawPoints`: a handful of draw calls, no per-frame allocation, and no
/// outline that could fold over itself on tight curls.
class _Stroke {
  new(Path path, {required double endTaper}) {
    final metric = path.computeMetrics().single;
    const n = FinoMarkPainter._samples;
    final pressure = <double>[];

    for (var i = 0; i <= n; i++) {
      final tangent = metric.getTangentForOffset(metric.length * i / n)!;
      final dir = tangent.vector / tangent.vector.distance;
      points.add(tangent.position);
      // Pressure only on the way down.
      pressure.add(((dir.dy - 0.15) / 0.85).clamp(0.0, 1.0));
    }

    // Smooth the pressure so the swell eases in and out like a real brush.
    const window = 11;
    for (var i = 0; i <= n; i++) {
      var sum = 0.0;
      var count = 0;
      for (var j = i - window; j <= i + window; j++) {
        if (j < 0 || j > n) continue;
        sum += pressure[j];
        count++;
      }
      final p = math.pow(sum / count, 1.3).toDouble();
      final s = i / n;
      // The brush lands softly and lifts with a little ink left on it.
      final taper = math.min(
        _ramp(s / 0.1, 0.3),
        _ramp((1 - s) / 0.1, endTaper),
      );
      widths.add(
        (FinoMarkPainter._hair +
                (FinoMarkPainter._swell - FinoMarkPainter._hair) * p) *
            taper,
      );
    }

    // Group sample indices by quantized width, keeping stroke order inside
    // each group so a prefix of the stroke is a prefix of every group.
    const step = FinoMarkPainter._swell / FinoMarkPainter._levels;
    final groups = <int, List<int>>{};
    for (var i = 0; i <= n; i++) {
      groups.putIfAbsent((widths[i] / step).round(), () => []).add(i);
    }
    for (final MapEntry(key: level, value: indices) in groups.entries) {
      final coords = Float32List(indices.length * 2);
      for (var k = 0; k < indices.length; k++) {
        coords[2 * k] = points[indices[k]].dx;
        coords[2 * k + 1] = points[indices[k]].dy;
      }
      _groups.add(
        _Group(math.max(level, 1) * step, Int32List.fromList(indices), coords),
      );
    }
  }

  final points = <Offset>[];
  final widths = <double>[];
  final _groups = <_Group>[];

  /// Eases from [floor] (at 0) up to 1 (at 1 and beyond).
  static double _ramp(double x, double floor) {
    final t = Curves.easeOut.transform(x.clamp(0.0, 1.0));
    return ui.lerpDouble(floor, 1, t)!;
  }

  /// Paints the first [t] (0..1) of the stroke.
  void draw(Canvas canvas, double t, Paint nib, Paint fill) {
    final last = points.length - 1;
    final end = last * t.clamp(0.0, 1.0);
    final whole = end.floor();

    for (final g in _groups) {
      final count = g.countUpTo(whole);
      if (count == 0) continue;
      nib.strokeWidth = g.width;
      canvas.drawRawPoints(
        ui.PointMode.points,
        Float32List.sublistView(g.coords, 0, count * 2),
        nib,
      );
    }

    // The brush tip, between samples.
    final frac = end - whole;
    if (whole < last) {
      canvas.drawCircle(
        Offset.lerp(points[whole], points[whole + 1], frac)!,
        ui.lerpDouble(widths[whole], widths[whole + 1], frac)! / 2,
        fill,
      );
    }
  }
}

/// Samples of one stroke that share a nib width, in stroke order.
class _Group {
  new(this.width, this.indices, this.coords);

  final double width;
  final Int32List indices;
  final Float32List coords;

  /// How many of these samples come at or before sample [index].
  int countUpTo(int index) {
    var lo = 0;
    var hi = indices.length;
    while (lo < hi) {
      final mid = (lo + hi) >> 1;
      if (indices[mid] <= index) {
        lo = mid + 1;
      } else {
        hi = mid;
      }
    }
    return lo;
  }
}
