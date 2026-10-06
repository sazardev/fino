import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../providers/order_provider.dart';
import '../providers/order_timeline_provider.dart';
import '../widgets/order_debt_card.dart';
import '../widgets/order_owner_actions.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/timeline_tile.dart';

/// Un pedido completo: resumen, cada deuda con lo que yo puedo hacer, lo que
/// solo quien pagó puede hacer y la bitácora (SPEC §5–§6, §11). Su concepto
/// es el título: aporta.
class OrderDetailPage extends ConsumerWidget {
  const new({required this.orderId, super.key, this.onBack});

  final String orderId;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider(orderId));
    final timeline =
        ref.watch(orderTimelineProvider(orderId)).value ?? const [];
    final summary = order.value;

    return SettingsShell(
      title: summary?.order.concept,
      onBack: onBack,
      loaded: order.hasValue,
      children: [
        if (summary == null)
          const EmptyState(
            icon: Icons.search_off_rounded,
            title: 'Este pedido ya no existe',
          )
        else ...[
          OrderSummaryCard(summary: summary),
          const SectionHeader('Deudas'),
          for (final debt in summary.debts) OrderDebtCard(debt: debt),
          OrderOwnerActions(summary: summary),
          if (timeline.isNotEmpty) const SectionHeader('Bitácora'),
          for (final entry in timeline.reversed)
            TimelineTile(
              entry: entry,
              teamId: summary.order.teamId,
              debts: {for (final d in summary.debts) d.id: d},
            ),
        ],
      ],
    );
  }
}
