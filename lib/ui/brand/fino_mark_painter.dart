import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Draws the Fino mark: a ring opened at the top right, an "equals" inside
/// (accounts settled) and a coin sitting in the opening.
///
/// Every progress value runs 0..1 (the coin may overshoot).
class FinoMarkPainter extends CustomPainter {
  FinoMarkPainter({
    required this.ring,
    required this.track,
    required this.bars,
    required this.coin,
    required this.color,
    required this.tint,
  });

  final double ring, track, bars, coin;
  final Color color, tint;

  static const _radius = 140.0;
  static const _ringStroke = 52.0;
  static const _barStroke = 34.0;
  static const _barHalf = 62.0;
  static const _barGap = 30.0;
  static const _coinRadius = 36.0;
  static const _box = 332.0;

  Paint _pen(Color c, double width) => Paint()
    ..color = c
    ..style = PaintingStyle.stroke
    ..strokeWidth = width
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(size.shortestSide / _box);

    // The full dial, faintly, until the ring takes its place.
    if (track > 0) {
      canvas.drawCircle(
        Offset.zero,
        _radius,
        _pen(color.withValues(alpha: 0.14 * track), _ringStroke),
      );
    }

    // 300 degrees clockwise from 3 o'clock; the gap faces the top right.
    if (ring > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: _radius),
        0,
        300 * math.pi / 180 * ring,
        false,
        _pen(color, _ringStroke),
      );
    }

    if (bars > 0) {
      for (final y in const [-_barGap, _barGap]) {
        canvas.drawLine(
          Offset(-_barHalf, y),
          Offset(-_barHalf + 2 * _barHalf * bars, y),
          _pen(tint, _barStroke),
        );
      }
    }

    if (coin > 0) {
      final angle = -30 * math.pi / 180;
      canvas.drawCircle(
        Offset(_radius * math.cos(angle), _radius * math.sin(angle)),
        _coinRadius * coin,
        Paint()..color = tint,
      );
    }
  }

  @override
  bool shouldRepaint(FinoMarkPainter old) =>
      ring != old.ring ||
      track != old.track ||
      bars != old.bars ||
      coin != old.coin ||
      color != old.color ||
      tint != old.tint;
}
