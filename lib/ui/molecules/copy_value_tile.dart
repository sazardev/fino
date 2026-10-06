import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../atoms/app_icon_button.dart';
import '../design/app_radii.dart';
import '../design/app_spacing.dart';
import '../feedback/app_toast.dart';
import '../theme/tabular_text.dart';

/// Un dato para copiar (CLABE, número de tarjeta, código): grande, legible y
/// con su botón de copiar.
class CopyValueTile extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    super.key,
    this.display,
    this.copiedMessage = 'Copiado',
  });

  final String label;

  /// Lo que se copia (sin espacios).
  final String value;

  /// Cómo se lee (p. ej. agrupado de 4 en 4); por defecto [value].
  final String? display;
  final String copiedMessage;

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (context.mounted) AppToast.show(context, copiedMessage);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: AppRadii.mdRadius,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: text.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                SelectableText(
                  display ?? value,
                  style: text.titleMedium!.tabular.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
          AppIconButton(
            tooltip: 'Copiar',
            onPressed: () => _copy(context),
            icon: const Icon(Icons.copy_rounded),
          ),
        ],
      ),
    );
  }
}
