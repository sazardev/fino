import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../providers/order_provider.dart';
import '../widgets/edit_order_form.dart';

/// "Editar pedido": concepto, total, fecha y nota (SPEC §5.5).
class EditOrderPage extends ConsumerWidget {
  const new({required this.orderId, super.key, this.onBack});

  final String orderId;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider(orderId));
    final summary = order.value;

    return SettingsShell(
      title: 'Editar pedido',
      onBack: onBack,
      loaded: order.hasValue,
      children: [
        if (summary == null)
          const EmptyState(
            icon: Icons.search_off_rounded,
            title: 'Este pedido ya no existe',
          )
        else
          EditOrderForm(order: summary.order, onDone: onBack),
      ],
    );
  }
}
