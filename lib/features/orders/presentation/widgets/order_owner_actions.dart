import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/confirm_action_row.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/molecules/settings_nav_tile.dart';
import '../../domain/enums/debt_status.dart';
import '../../domain/enums/order_status.dart';
import '../../domain/views/order_summary.dart';
import '../navigation/orders_navigator_provider.dart';
import '../providers/commands/cancel_order_command_provider.dart';
import '../text/describe_order_error.dart';
import 'redistribute_row.dart';

/// Lo que solo quien pagó puede hacer con su pedido (SPEC §5.5, §6.6).
class OrderOwnerActions extends ConsumerWidget {
  const new({required this.summary, super.key});

  final OrderSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(sessionUserIdProvider);
    final order = summary.order;
    if (me != order.creditorId) return const SizedBox.shrink();
    final navigator = ref.read(ordersNavigatorProvider);
    final open = summary.status == OrderStatus.open;
    final pending = [
      for (final d in summary.debts)
        if (d.status == DebtStatus.pending) d,
    ];
    final untouched = summary.debts.every(
      (d) => d.status == DebtStatus.pending || d.status == DebtStatus.cancelled,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader('Tu pedido'),
        SettingsNavTile(
          icon: Icons.edit_rounded,
          title: 'Editar pedido',
          subtitle: 'Concepto, total, fecha y nota',
          onTap: () => navigator.openEditOrder(order.id),
        ),
        if (open)
          SettingsNavTile(
            icon: Icons.person_add_rounded,
            title: 'Agregar a alguien',
            subtitle: 'Otra persona que también debe',
            onTap: () => navigator.openAddDebtor(order.id),
          ),
        if (pending.isNotEmpty) ...[
          SettingsNavTile(
            icon: Icons.notifications_active_rounded,
            title: 'Recordar a quienes deben',
            subtitle: '${pending.length} con pago pendiente',
            onTap: () => navigator.openNotice(order.teamId, [
              for (final d in pending) d.debtorId,
            ]),
          ),
          RedistributeRow(summary: summary),
        ],
        if (open && untouched)
          ConfirmActionRow(
            icon: Icons.delete_outline_rounded,
            label: 'Cancelar pedido',
            confirmLabel: 'Confirmar: cancelar pedido',
            hint: 'Se cancelan todas las deudas y se avisa a cada quien',
            onConfirmed: () => runAction(
              context,
              () => ref.read(cancelOrderCommandProvider)(
                actorId: me!,
                orderId: order.id,
              ),
              success: 'Pedido cancelado',
              describe: describeOrderError,
            ),
          ),
      ],
    );
  }
}
