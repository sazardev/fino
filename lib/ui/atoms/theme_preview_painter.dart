import 'package:flutter/material.dart';

/// Outline of the preview, painted above its content.
class PreviewFramePainter extends CustomPainter {
  const new(this.color, this.radius);

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) => canvas.drawRRect(
    RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
    Paint()
      ..style = PaintingStyle.stroke
      ..color = color,
  );

  @override
  bool shouldRepaint(PreviewFramePainter old) => old.color != color;
}

/// The miniature screen itself.
class PreviewPainter extends CustomPainter {
  const new(this.scheme, {required this.density, this.split});

  final ColorScheme scheme;

  /// When set, the lower-right half of the screen is drawn with this scheme.
  final ColorScheme? split;
  final double density;

  @override
  void paint(Canvas canvas, Size size) {
    _screen(canvas, size, scheme);
    if (split == null) return;
    canvas
      ..save()
      ..clipPath(
        Path()
          ..moveTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close(),
      );
    _screen(canvas, size, split!);
    canvas.restore();
  }

  void _screen(Canvas canvas, Size size, ColorScheme s) {
    final w = size.width;
    final pad = w * 0.12;
    final line = w * 0.07 * density;
    Paint fill(Color c) => Paint()..color = c;
    void bar(double x, double y, double bw, double bh, Color c) =>
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, bw, bh),
            Radius.circular(bh / 2),
          ),
          fill(c),
        );

    canvas.drawRect(Offset.zero & size, fill(s.surface));
    bar(pad, pad, w * 0.42, line * 1.4, s.onSurface.withValues(alpha: 0.75));

    var y = pad + line * 1.4 + line;
    final lines = density < 1 ? 3 : (density > 1 ? 1 : 2);
    for (var i = 0; i < lines; i++) {
      bar(
        pad,
        y,
        w - pad * 2 - (i.isOdd ? w * 0.2 : 0),
        line * 0.8,
        s.onSurfaceVariant.withValues(alpha: 0.45),
      );
      y += line * 1.7;
    }

    final cardH = size.height * 0.26;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(pad, y + line * 0.4, w - pad * 2, cardH),
        Radius.circular(w * 0.1),
      ),
      fill(s.surfaceContainerHigh),
    );
    bar(
      pad * 1.7,
      y + line * 0.4 + cardH - line * 2.2,
      w * 0.34,
      line * 1.4,
      s.primary,
    );

    final navH = size.height * 0.16;
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - navH, w, navH),
      fill(s.surfaceContainer),
    );
    bar(pad, size.height - navH * 0.68, w * 0.26, navH * 0.36, s.primary);
    bar(
      w * 0.5,
      size.height - navH * 0.6,
      w * 0.14,
      navH * 0.2,
      s.onSurfaceVariant.withValues(alpha: 0.5),
    );
    bar(
      w * 0.74,
      size.height - navH * 0.6,
      w * 0.14,
      navH * 0.2,
      s.onSurfaceVariant.withValues(alpha: 0.5),
    );
  }

  @override
  bool shouldRepaint(PreviewPainter old) =>
      old.scheme != scheme || old.split != split || old.density != density;
}
