import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/design/app_durations.dart';
import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../domain/entities/debt.dart';
import '../../domain/enums/review_decision.dart';
import '../navigation/orders_navigator_provider.dart';
import '../providers/available_debt_actions.dart';
import '../providers/debt_action.dart';
import 'debt_action_bar.dart';
import 'debt_action_runner.dart';
import 'debt_editor.dart';
import 'order_debt_header.dart';

/// Una deuda dentro de su pedido, con lo que yo puedo hacer con ella.
/// Rechazar, objetar y cambiar el monto se capturan en el mismo lugar.
class OrderDebtCard extends ConsumerStatefulWidget {
  const new({required this.debt, super.key});

  final Debt debt;

  @override
  ConsumerState<OrderDebtCard> createState() => _OrderDebtCardState();
}

class _OrderDebtCardState extends ConsumerState<OrderDebtCard> {
  DebtAction? _editing;

  Future<void> _act(DebtAction action) async {
    final runner = DebtActionRunner(context, ref, widget.debt);
    switch (action) {
      case DebtAction.reject || DebtAction.object || DebtAction.editAmount:
        setState(() => _editing = action);
      case DebtAction.confirm:
        await runner.review(ReviewDecision.confirm);
      case DebtAction.cancel:
        await runner.cancel();
      case DebtAction.undoConfirmation:
        await runner.undoConfirmation();
      case DebtAction.retract:
        await runner.retract();
      case DebtAction.pay:
        ref
            .read(ordersNavigatorProvider)
            .openPay(widget.debt.teamId, widget.debt.creditorId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final me = ref.watch(sessionUserIdProvider);
    final actions = AvailableDebtActions.of(widget.debt, me);
    final editing = _editing;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: AppRadii.mdRadius,
      ),
      child: AnimatedSize(
        duration: AppDurations.medium,
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OrderDebtHeader(debt: widget.debt),
            if (editing != null) ...[
              const SizedBox(height: AppSpacing.md),
              DebtEditor(
                debt: widget.debt,
                action: editing,
                onClose: () => setState(() => _editing = null),
              ),
            ] else if (actions.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              DebtActionBar(actions: actions, onAction: _act),
            ],
          ],
        ),
      ),
    );
  }
}
