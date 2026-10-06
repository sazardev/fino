import 'package:flutter/material.dart';

import '../atoms/bouncy_tap.dart';
import '../atoms/icon_badge.dart';
import '../design/app_durations.dart';
import '../design/app_radii.dart';
import '../design/app_spacing.dart';
import '../responsive/responsive.dart';

/// Row that leads to another screen: icon badge, title, a subtitle with the
/// current value, and a chevron. On a watch it collapses to icon + title.
/// [selected] fills it with the accent.
class SettingsNavTile extends StatelessWidget {
  const new({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
    this.subtitle,
    this.selected = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final watch = Responsive.of(context).isWatch;

    final foreground = selected ? scheme.onPrimary : null;
    final muted = selected
        ? scheme.onPrimary.withValues(alpha: 0.8)
        : scheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: BouncyTap(
        onTap: onTap,
        pressedScale: 0.98,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: EdgeInsets.all(watch ? AppSpacing.md : AppSpacing.lg),
          decoration: BoxDecoration(
            color: selected ? scheme.primary : scheme.surfaceContainerHigh,
            borderRadius: watch ? AppRadii.smRadius : AppRadii.mdRadius,
          ),
          child: Row(
            children: [
              IconBadge(icon: icon, size: watch ? 32 : 40, inverted: selected),
              SizedBox(width: watch ? AppSpacing.md : AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: (watch ? text.bodyMedium : text.bodyLarge)
                          ?.copyWith(color: foreground),
                    ),
                    if (subtitle != null && !watch) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodySmall?.copyWith(color: muted),
                      ),
                    ],
                  ],
                ),
              ),
              if (!watch) Icon(Icons.chevron_right_rounded, color: muted),
            ],
          ),
        ),
      ),
    );
  }
}
