import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../atoms/bouncy_tap.dart';
import '../design/app_curves.dart';
import '../design/app_radii.dart';
import '../design/app_spacing.dart';

/// A selectable tile: tonal when idle, accent-filled when [selected].
class SelectableCard extends StatelessWidget {
  const SelectableCard({
    super.key,
    required this.label,
    this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return BouncyTap(
      onTap: () {
        Haptics.select();
        onTap();
      },
      pressedScale: 0.95,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: AppCurves.select,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surfaceContainerHigh,
          borderRadius: AppRadii.mdRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: selected ? scheme.onPrimary : null,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.bodySmall?.copyWith(
                  color: selected
                      ? scheme.onPrimary.withValues(alpha: 0.8)
                      : scheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
