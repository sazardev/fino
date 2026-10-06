import 'package:flutter/material.dart';

import '../../core/money/money.dart';
import '../design/app_radii.dart';
import '../design/app_spacing.dart';
import 'amount_text.dart';

/// Una cifra grande con su etiqueta ("Te deben $1,200.00").
class BalanceCard extends StatelessWidget {
  const new({
    required this.label,
    required this.amount,
    required this.direction,
    super.key,
    this.caption,
  });

  final String label;
  final Money amount;

  /// `true` me deben, `false` debo (signo + color, DESIGN §2.4).
  final bool direction;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: AppRadii.lgRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: text.labelLarge?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.xs),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: AmountText(
              amount,
              direction: amount.isZero ? null : direction,
              style: text.headlineSmall,
            ),
          ),
          if (caption != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              caption!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}
