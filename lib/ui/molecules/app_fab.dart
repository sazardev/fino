import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../atoms/bouncy_tap.dart';
import '../atoms/chubby_icon.dart';
import '../design/app_curves.dart';
import '../design/app_durations.dart';
import '../responsive/responsive.dart';

/// The screen's one primary action: a flat `primary` circle (no shadow) with
/// only an icon, on every screen size. [label] is the tooltip and what screen
/// readers announce.
class AppFab extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Capped so it stays slim on tablets and wide web windows.
    final size = 56.0 * math.min(Responsive.of(context).scale, 1.1);

    return Tooltip(
      message: label,
      child: BouncyTap(
        onTap: () {
          Haptics.confirm();
          onPressed();
        },
        focusBorderRadius: BorderRadius.circular(size),
        child: Semantics(
          button: true,
          label: label,
          excludeSemantics: true,
          child: AnimatedContainer(
            duration: AppDurations.medium,
            curve: AppCurves.settle,
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: scheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(child: ChubbyIcon(icon, color: scheme.onPrimary)),
          ),
        ),
      ),
    );
  }
}
