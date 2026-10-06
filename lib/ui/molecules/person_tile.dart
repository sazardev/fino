import 'package:flutter/material.dart';

import '../atoms/bouncy_tap.dart';
import '../atoms/person_avatar.dart';
import '../design/app_radii.dart';
import '../design/app_spacing.dart';

/// Una persona en una lista: su cara, nombre, una línea de contexto y algo a
/// la derecha (un monto, un rol). Con [onTap] rebota y lleva a otro lado.
class PersonTile extends StatelessWidget {
  const new({
    required this.name,
    required this.seed,
    super.key,
    this.photoUrl,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final String name;
  final String seed;
  final String? photoUrl;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  static const double _withAvatar = 220;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final tile = Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: AppRadii.mdRadius,
      ),
      // On a watch the face gives its room to the name and the amount.
      child: LayoutBuilder(
        builder: (context, box) => Row(
          children: [
            if (box.maxWidth >= _withAvatar) ...[
              PersonAvatar(
                name: name,
                seed: seed,
                photoUrl: photoUrl,
                size: 44,
              ),
              const SizedBox(width: AppSpacing.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodyLarge,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: FittedBox(fit: BoxFit.scaleDown, child: trailing),
              ),
            ],
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: onTap == null
          ? tile
          : BouncyTap(onTap: onTap, pressedScale: 0.98, child: tile),
    );
  }
}
