import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../design/app_curves.dart';
import '../design/app_spacing.dart';
import 'bouncy_tap.dart';

/// Una opción de filtro: píldora tonal que se llena de acento al elegirse.
class ChoicePill extends StatelessWidget {
  const new({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = selected ? scheme.onPrimary : scheme.onSurface;

    return BouncyTap(
      onTap: () {
        Haptics.select();
        onTap();
      },
      pressedScale: 0.94,
      focusBorderRadius: const BorderRadius.all(Radius.circular(999)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: AppCurves.select,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: ShapeDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainerHigh,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: foreground),
              const SizedBox(width: AppSpacing.xs),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge
                  ?.copyWith(color: foreground, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
