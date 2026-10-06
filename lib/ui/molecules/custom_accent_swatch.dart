import 'package:flutter/material.dart';

import '../atoms/accent_swatch.dart';

/// The "custom color" swatch: a neutral disc with a picker icon until the
/// user has a custom color, then that color.
class CustomAccentSwatch extends StatelessWidget {
  const new({
    required this.color,
    required this.selected,
    required this.onTap,
    super.key,
    this.size = 52,
  });

  final Color? color;
  final bool selected;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final neutral = Theme.of(context).colorScheme.surfaceContainerHighest;

    return AccentSwatch(
      color: color ?? neutral,
      selected: selected,
      onTap: onTap,
      size: size,
      icon: color == null ? Icons.colorize_rounded : null,
    );
  }
}
