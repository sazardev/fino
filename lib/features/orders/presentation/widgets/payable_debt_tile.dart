import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/atoms/chubby_icon.dart';
import '../../domain/entities/debt.dart';
import '../providers/orders_by_id_provider.dart';
import '../providers/pay_selection_controller.dart';
import 'debt_line.dart';

/// Una deuda en *Pagar*: se marca o desmarca para incluirla (G1).
class PayableDebtTile extends ConsumerWidget {
  const new({required this.debt, required this.selected, super.key});

  final Debt debt;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final concept = ref.watch(
      ordersByIdProvider.select((o) => o.value?[debt.orderId]?.concept),
    );

    return Semantics(
      checked: selected,
      child: DebtLine(
        concept: concept ?? 'Pedido',
        status: selected ? 'Incluida' : 'Fuera de este pago',
        strongStatus: selected,
        amount: debt.amount,
        leading: ChubbyIcon(
          selected
              ? Icons.check_circle_rounded
              : Icons.radio_button_unchecked_rounded,
          color: selected ? scheme.primary : scheme.onSurfaceVariant,
        ),
        onTap: () => ref
            .read(
              paySelectionControllerProvider(
                debt.teamId,
                debt.creditorId,
              ).notifier,
            )
            .toggle(debt.id),
      ),
    );
  }
}
