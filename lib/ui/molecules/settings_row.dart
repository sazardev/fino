import 'package:flutter/material.dart';

import '../atoms/bouncy_tap.dart';
import '../design/app_radii.dart';
import '../design/app_spacing.dart';

/// Flat row: label (+ optional subtitle) on the left, a trailing control on
/// the right. No ripple; bounces as a whole when [onTap] is given.
class SettingsRow extends StatelessWidget {
  const new({
    required this.label,
    required this.trailing,
    super.key,
    this.subtitle,
    this.onTap,
    this.labelColor,
  });

  final String label;
  final String? subtitle;
  final Widget trailing;
  final VoidCallback? onTap;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: text.bodyLarge?.copyWith(color: labelColor)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: text.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          trailing,
        ],
      ),
    );

    if (onTap == null) return content;

    return BouncyTap(
      onTap: onTap,
      pressedScale: 0.98,
      child: ClipRRect(borderRadius: AppRadii.mdRadius, child: content),
    );
  }
}
