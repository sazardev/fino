import 'package:flutter/material.dart';

import '../responsive/ui_size.dart';
import '../theme/app_color_scheme.dart';
import 'theme_preview_painter.dart';

/// A miniature screen showing how a theme looks: surfaces, a card with an
/// accent button and a navigation bar. [uiSize] changes the density of the
/// content, and [ThemeMode.system] splits the screen light / dark.
class ThemePreview extends StatelessWidget {
  const new({
    required this.mode,
    required this.accent,
    required this.uiSize,
    super.key,
    this.width = 52,
    this.height = 68,
  });

  final ThemeMode mode;
  final Color accent;
  final UiSize uiSize;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final light = buildColorScheme(accent, Brightness.light);
    final dark = buildColorScheme(accent, Brightness.dark);
    final outline = Theme.of(context).colorScheme.outlineVariant;

    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.22),
        child: CustomPaint(
          foregroundPainter: PreviewFramePainter(outline, width * 0.22),
          size: Size(width, height),
          painter: PreviewPainter(
            mode == ThemeMode.dark ? dark : light,
            split: mode == ThemeMode.system ? dark : null,
            density: uiSize.multiplier,
          ),
        ),
      ),
    );
  }
}
