import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../../core/utils/color_contrast.dart';
import '../design/app_curves.dart';
import 'bouncy_tap.dart';

/// One selectable color circle. Fixed size by design: it must never stretch
/// to fill a grid cell. Selection morphs the circle into a squircle (+ check).
class AccentSwatch extends StatelessWidget {
  const AccentSwatch({
    super.key,
    required this.color,
    required this.selected,
    required this.onTap,
    this.size = 52,
    this.icon,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;
  final double size;

  /// Shown while not selected (e.g. the "custom color" picker icon).
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final foreground = foregroundOn(color);

    return BouncyTap(
      onTap: () {
        Haptics.select();
        onTap();
      },
      focusBorderRadius: BorderRadius.circular(size),
      pressedScale: 0.88,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: AppCurves.select,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            selected ? size * 0.32 : size / 2,
          ),
        ),
        child: selected
            ? Icon(Icons.check_rounded, color: foreground)
            : (icon == null ? null : Icon(icon, color: foreground)),
      ),
    );
  }
}
