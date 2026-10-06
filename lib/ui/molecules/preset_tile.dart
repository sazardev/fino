import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../atoms/bouncy_tap.dart';
import '../design/app_curves.dart';
import '../design/app_durations.dart';
import '../design/app_radii.dart';
import '../design/app_spacing.dart';

/// One row of a list of presets: a [preview] on the left, a name and a hint,
/// and a check that fills in when [selected]. Selected rows fill with the
/// accent, like every other selection.
class PresetTile extends StatelessWidget {
  const new({
    required this.preview,
    required this.label,
    required this.hint,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final Widget preview;
  final String label;
  final String hint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      selected: selected,
      label: '$label, $hint',
      excludeSemantics: true,
      child: BouncyTap(
        onTap: () {
          Haptics.select();
          onTap();
        },
        pressedScale: 0.98,
        child: AnimatedContainer(
          duration: AppDurations.medium,
          curve: AppCurves.select,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: selected ? scheme.primary : scheme.surfaceContainerHigh,
            borderRadius: AppRadii.mdRadius,
          ),
          child: Row(
            children: [
              preview,
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: selected ? scheme.onPrimary : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      hint,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodySmall?.copyWith(
                        color: selected
                            ? scheme.onPrimary.withValues(alpha: 0.8)
                            : scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              _Check(selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}

class _Check extends StatelessWidget {
  const new({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: AppDurations.medium,
      curve: AppCurves.select,
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? scheme.onPrimary : scheme.surfaceContainerHighest,
      ),
      child: selected
          ? Icon(Icons.check_rounded, size: 18, color: scheme.primary)
          : null,
    );
  }
}
