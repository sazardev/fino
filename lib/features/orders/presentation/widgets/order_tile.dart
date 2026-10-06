import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/people_provider.dart';
import '../../../../core/directory/person_label.dart';
import '../../../../core/format/date_label.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../core/time/clock_provider.dart';
import '../../../../ui/atoms/bouncy_tap.dart';
import '../../../../ui/atoms/icon_badge.dart';
import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/amount_text.dart';
import '../../../../ui/molecules/status_pill.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/views/order_summary.dart';
import '../navigation/orders_navigator_provider.dart';
import '../text/order_status_label.dart';

/// Un pedido en la lista: qué fue, quién pagó, cuándo y cómo va.
class OrderTile extends ConsumerWidget {
  const new({required this.summary, super.key});

  final OrderSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final order = summary.order;
    final people = ref.watch(peopleProvider).value ?? const {};
    final creditor = PersonLabel.of(
      people,
      teamId: order.teamId,
      userId: order.creditorId,
      me: ref.watch(sessionUserIdProvider),
    );
    final when = DateLabel.of(order.spentAt, now: ref.watch(clockProvider)());
    final (paid, total) = (summary.progress.confirmed, summary.progress.total);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: BouncyTap(
        pressedScale: 0.98,
        onTap: () => ref.read(ordersNavigatorProvider).openOrder(order.id),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: AppRadii.mdRadius,
          ),
          child: Row(
            children: [
              const IconBadge(icon: Icons.receipt_long_rounded),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.concept,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodyLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$creditor · $when · $paid de $total pagadas',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Shrinks before it overflows a watch.
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AmountText(order.total),
                      const SizedBox(height: AppSpacing.xs),
                      StatusPill(
                        OrderStatusLabel.of(summary.status),
                        strong: summary.status == OrderStatus.open,
                      ),
                    ],
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
