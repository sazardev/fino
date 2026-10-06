import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../atoms/bouncy_tap.dart';
import '../atoms/chubby_icon.dart';
import '../design/app_curves.dart';
import '../design/app_durations.dart';
import '../design/app_spacing.dart';
import '../responsive/responsive.dart';

/// The screen's one primary action: a flat `primary` pill (no shadow). Shows
/// its label on wide screens, only the icon otherwise.
class AppFab extends StatelessWidget {
  const AppFab({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final r = Responsive.of(context);
    final double height = 56 * math.min(r.scale, 1.25);

    return Tooltip(
      message: label,
      child: BouncyTap(
        onTap: () {
          Haptics.confirm();
          onPressed();
        },
        pressedScale: 0.94,
        focusBorderRadius: BorderRadius.circular(height),
        child: Semantics(
          button: true,
          label: label,
          excludeSemantics: true,
          child: AnimatedContainer(
            duration: AppDurations.medium,
            curve: AppCurves.settle,
            height: height,
            constraints: BoxConstraints(minWidth: height),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(height),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChubbyIcon(icon, color: scheme.onPrimary),
                if (r.isExpanded) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
