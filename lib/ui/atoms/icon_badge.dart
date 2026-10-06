import 'package:flutter/material.dart';

import '../design/app_radii.dart';
import 'chubby_icon.dart';

/// Rounded square with a tinted fill and a plump icon. [inverted] is for use
/// on a primary-filled surface.
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    this.size = 40,
    this.inverted = false,
  });

  final IconData icon;
  final double size;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final foreground = inverted ? scheme.onPrimary : scheme.primary;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: foreground.withValues(alpha: inverted ? 0.18 : 0.14),
        borderRadius: AppRadii.smRadius,
      ),
      child: ChubbyIcon(icon, size: size * 0.55, color: foreground),
    );
  }
}
