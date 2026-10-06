import 'package:flutter/material.dart';

import '../design/app_spacing.dart';

/// Etiqueta corta de estado ("Pendiente", "Por confirmar"). [strong] la llena
/// con el acento para lo que pide atención.
class StatusPill extends StatelessWidget {
  const new(this.label, {super.key, this.strong = false, this.danger = false});

  final String label;
  final bool strong;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (background, foreground) = danger
        ? (scheme.errorContainer, scheme.onErrorContainer)
        : strong
        ? (scheme.primary, scheme.onPrimary)
        : (scheme.surfaceContainerHighest, scheme.onSurfaceVariant);

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: background,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 2,
        ),
        child: Text(
          label,
          maxLines: 1,
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: foreground, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
