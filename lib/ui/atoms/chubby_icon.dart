import 'package:flutter/material.dart';

/// A plump version of a Material icon.
///
/// Icon fonts are static, so weight can't be dialed up. The glyph is drawn
/// twice instead: once as a round-joined stroke (fattens every edge), once as
/// the usual fill on top. Pair it with `*_rounded` icons.
///
/// Size and color come from the ambient [IconTheme] unless given.
class ChubbyIcon extends StatelessWidget {
  const ChubbyIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.plump = 0.055,
  });

  final IconData icon;
  final double? size;
  final Color? color;

  /// Extra thickness as a fraction of the icon size.
  final double plump;

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    final s = size ?? theme.size ?? 24.0;
    final c = (color ?? theme.color ?? Colors.black).withValues(
      alpha: theme.opacity ?? 1.0,
    );

    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * plump
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = c;

    return SizedBox(
      width: s,
      height: s,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ExcludeSemantics(
            child: RichText(
              textScaler: TextScaler.noScaling,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.visible,
              text: TextSpan(
                text: String.fromCharCode(icon.codePoint),
                style: TextStyle(
                  inherit: false,
                  fontFamily: icon.fontFamily,
                  package: icon.fontPackage,
                  fontSize: s,
                  height: 1,
                  foreground: outline,
                ),
              ),
            ),
          ),
          Icon(icon, size: s, color: c),
        ],
      ),
    );
  }
}
