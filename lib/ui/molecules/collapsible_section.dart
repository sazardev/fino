import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../../core/utils/reduced_motion.dart';
import '../atoms/bouncy_tap.dart';
import '../atoms/icon_badge.dart';
import '../design/app_curves.dart';
import '../design/app_durations.dart';
import '../design/app_radii.dart';
import '../design/app_spacing.dart';
import '../responsive/responsive.dart';

/// A titled card whose body folds away. While folded, [summary] shows the
/// current value at a glance, so a section can stay closed and still answer
/// "what is this set to?".
class CollapsibleSection extends StatefulWidget {
  const new({
    required this.icon,
    required this.title,
    required this.child,
    super.key,
    this.summary,
    this.initiallyExpanded = true,
  });

  final IconData icon;
  final String title;

  /// Shown on the right of the header while folded.
  final Widget? summary;
  final Widget child;
  final bool initiallyExpanded;

  @override
  State<CollapsibleSection> createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<CollapsibleSection> {
  late bool _expanded = widget.initiallyExpanded;

  void _toggle() {
    Haptics.select();
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final duration = context.reduceMotion ? Duration.zero : AppDurations.medium;
    final text = Theme.of(context).textTheme;
    final watch = Responsive.of(context).isWatch;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: AppRadii.lgRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            button: true,
            expanded: _expanded,
            child: BouncyTap(
              onTap: _toggle,
              pressedScale: 0.99,
              focusBorderRadius: AppRadii.lgRadius,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    IconBadge(icon: widget.icon, size: 36),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (widget.summary != null && !watch)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 120),
                        child: AnimatedOpacity(
                          opacity: _expanded ? 0 : 1,
                          duration: duration,
                          curve: AppCurves.select,
                          child: DefaultTextStyle.merge(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                            child: widget.summary!,
                          ),
                        ),
                      ),
                    const SizedBox(width: AppSpacing.sm),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: duration,
                      curve: AppCurves.settle,
                      child: Icon(
                        Icons.expand_more_rounded,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: duration,
            curve: AppCurves.settle,
            alignment: Alignment.topCenter,
            child: _expanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: widget.child,
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
