import 'package:flutter/material.dart';

import '../../core/haptics/haptics.dart';
import '../atoms/bouncy_tap.dart';
import '../design/app_durations.dart';
import '../design/app_spacing.dart';
import 'app_button_tone.dart';

/// Botón de texto en píldora, plano, con rebote. [busy] muestra un spinner y
/// lo desactiva; sin [onPressed] queda apagado.
class AppButton extends StatelessWidget {
  const new({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.tone = AppButtonTone.primary,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonTone tone;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onPressed != null && !busy;
    final (background, foreground) = switch (tone) {
      AppButtonTone.primary => (scheme.primary, scheme.onPrimary),
      AppButtonTone.tonal => (scheme.surfaceContainerHigh, scheme.onSurface),
      AppButtonTone.danger => (scheme.errorContainer, scheme.onErrorContainer),
    };

    return BouncyTap(
      onTap: enabled
          ? () {
              Haptics.confirm();
              onPressed!();
            }
          : null,
      pressedScale: 0.96,
      focusBorderRadius: const BorderRadius.all(Radius.circular(999)),
      child: AnimatedOpacity(
        duration: AppDurations.fast,
        opacity: enabled || busy ? 1 : 0.45,
        child: Container(
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          decoration: ShapeDecoration(
            color: background,
            shape: const StadiumBorder(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (busy)
                SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: foreground,
                  ),
                )
              else if (icon != null)
                Icon(icon, size: 20, color: foreground),
              if (busy || icon != null) const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
