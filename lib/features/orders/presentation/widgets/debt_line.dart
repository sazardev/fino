import 'package:flutter/material.dart';

import '../../../../core/money/money.dart';
import '../../../../ui/atoms/bouncy_tap.dart';
import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/amount_text.dart';
import '../../../../ui/molecules/status_pill.dart';

/// Una deuda en una lista: de qué pedido es, su estado y su monto.
class DebtLine extends StatelessWidget {
  const new({
    required this.concept,
    required this.status,
    required this.amount,
    super.key,
    this.caption,
    this.direction,
    this.strongStatus = false,
    this.leading,
    this.onTap,
  });

  final String concept;
  final String status;
  final Money amount;
  final String? caption;
  final bool? direction;
  final bool strongStatus;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final line = Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: AppRadii.mdRadius,
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  concept,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    StatusPill(status, strong: strongStatus),
                    if (caption != null)
                      Text(
                        caption!,
                        style: text.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          AmountText(amount, direction: direction),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: onTap == null
          ? line
          : BouncyTap(onTap: onTap, pressedScale: 0.98, child: line),
    );
  }
}
