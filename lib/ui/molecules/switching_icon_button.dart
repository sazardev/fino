import 'package:flutter/material.dart';

import '../atoms/app_icon_button.dart';
import '../atoms/chubby_icon.dart';
import '../design/app_curves.dart';
import '../design/app_durations.dart';

/// An icon button whose icon swaps with a spin-and-scale when [active]
/// flips, and whose circle fills while active (play ↔ pause, add ↔ done).
class SwitchingIconButton extends StatelessWidget {
  const new({
    required this.active,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.tooltip,
    required this.onPressed,
    super.key,
    this.enabled = true,
    this.autofocus = false,
  });

  final bool active;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool enabled;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AppIconButton(
      tooltip: tooltip,
      selected: active,
      autofocus: autofocus,
      onPressed: enabled ? onPressed : null,
      icon: AnimatedSwitcher(
        duration: AppDurations.medium,
        switchInCurve: AppCurves.emphasized,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) => RotationTransition(
          turns: Tween<double>(begin: 0.25, end: 0).animate(animation),
          child: ScaleTransition(scale: animation, child: child),
        ),
        child: ChubbyIcon(
          active ? activeIcon : inactiveIcon,
          key: ValueKey(active),
          // Active fills the circle, so the icon takes the on-primary color.
          color: active
              ? null
              : (enabled
                    ? scheme.primary
                    : scheme.onSurface.withValues(alpha: 0.38)),
        ),
      ),
    );
  }
}
