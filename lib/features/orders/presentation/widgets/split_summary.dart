import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/amount_text.dart';
import '../providers/draft_split_provider.dart';
import '../text/order_failure_message.dart';

/// Cómo queda el reparto: mi parte o, si algo no cuadra, por qué.
class SplitSummary extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final split = ref.watch(draftSplitProvider);
    final problem = split.problem;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: problem != null
          ? Text(
              OrderFailureMessage.of(problem),
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            )
          : Row(
              children: [
                Expanded(
                  child: Text(
                    'Tu parte (no es deuda)',
                    style: text.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                AmountText(split.creditorShare),
              ],
            ),
    );
  }
}
