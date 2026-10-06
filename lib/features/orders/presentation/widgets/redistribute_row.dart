import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/settings_row.dart';
import '../../domain/enums/debt_status.dart';
import '../../domain/split/split_entry.dart';
import '../../domain/views/order_summary.dart';
import '../providers/commands/redistribute_pending_command_provider.dart';
import '../text/describe_order_error.dart';

/// "Re-repartir": lo pendiente en partes iguales, contándome (SPEC §5.5). Lo
/// ya reportado o confirmado no cambia.
class RedistributeRow extends ConsumerWidget {
  const new({required this.summary, super.key});

  final OrderSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsRow(
      label: 'Repartir lo pendiente en partes iguales',
      subtitle: 'Incluye tu parte; los pagos hechos no cambian',
      trailing: const Icon(Icons.balance_rounded),
      onTap: () => runAction(
        context,
        () => ref.read(redistributePendingCommandProvider)(
          actorId: ref.read(sessionUserIdProvider)!,
          orderId: summary.order.id,
          creditorIncluded: true,
          entries: [
            for (final d in summary.debts)
              if (d.status == DebtStatus.pending) SplitEntry(d.debtorId),
          ],
        ),
        success: 'Repartido de nuevo',
        describe: describeOrderError,
      ),
    );
  }
}
