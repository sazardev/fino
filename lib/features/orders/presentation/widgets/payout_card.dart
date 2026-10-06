import 'package:flutter/material.dart';

import '../../../../core/directory/directory_payout.dart';
import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/copy_value_tile.dart';

/// A dónde pagarle a alguien: banco, número para copiar y titular (SPEC M4).
/// Sin [payout] explica por qué aún no se ve.
class PayoutCard extends StatelessWidget {
  const new({required this.payout, required this.name, super.key});

  final DirectoryPayout? payout;
  final String name;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final payout = this.payout;

    if (payout == null) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHigh,
          borderRadius: AppRadii.mdRadius,
        ),
        child: Text(
          'Todavía no ves la cuenta de $name. Aparece en cuanto se '
          'sincronice; si no, pídele que la configure en el equipo.',
          style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
      );
    }

    final details = [?payout.bankName, ?payout.holderName].join(' · ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CopyValueTile(
          label: payout.isClabe ? 'CLABE' : 'Tarjeta',
          value: payout.number,
          display: payout.grouped,
          copiedMessage: payout.isClabe ? 'CLABE copiada' : 'Número copiado',
        ),
        if (details.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              0,
            ),
            child: Text(
              details,
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
      ],
    );
  }
}
