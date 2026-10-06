import 'package:flutter/material.dart';

/// Soft tinted halo behind [child] while it has keyboard / D-pad focus. Flat
/// like the rest of the system: no border, no shadow.
class FocusHalo extends StatelessWidget {
  const new({
    required this.visible,
    required this.borderRadius,
    required this.child,
    super.key,
  });

  final bool visible;
  final BorderRadius borderRadius;
  final Widget child;

  static const double _margin = 6;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary.withValues(alpha: 0.22);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (visible)
          Positioned.fill(
            left: -_margin,
            top: -_margin,
            right: -_margin,
            bottom: -_margin,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: borderRadius,
              ),
            ),
          ),
        child,
      ],
    );
  }
}
