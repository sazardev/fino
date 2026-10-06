import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../domain/split/split_entry.dart';
import '../navigation/orders_navigator_provider.dart';
import '../providers/commands/create_order_command_provider.dart';
import '../providers/draft_split_provider.dart';
import '../providers/draft_team_id_provider.dart';
import '../providers/order_draft_controller.dart';
import '../text/describe_order_error.dart';

/// Guarda el pedido con el mismo reparto que se ve en pantalla.
class SaveOrderButton extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<SaveOrderButton> createState() => _SaveOrderButtonState();
}

class _SaveOrderButtonState extends ConsumerState<SaveOrderButton> {
  var _busy = false;

  Future<void> _save() async {
    final draft = ref.read(orderDraftControllerProvider);
    final teamId = ref.read(draftTeamIdProvider);
    if (teamId == null) return;
    setState(() => _busy = true);
    String? created;
    await runAction(
      context,
      () async {
        final order = await ref.read(createOrderCommandProvider)(
          actorId: ref.read(sessionUserIdProvider)!,
          teamId: teamId,
          concept: draft.concept,
          note: draft.note,
          total: draft.total!,
          spentAt: draft.spentAt,
          creditorIncluded: draft.creditorIncluded,
          entries: [
            for (final id in draft.participants)
              SplitEntry(id, fixedAmount: draft.fixed[id]),
          ],
        );
        created = order.id;
      },
      success: 'Pedido registrado: ya les avisamos',
      describe: describeOrderError,
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (created case final id?) {
      ref.read(ordersNavigatorProvider).showCreatedOrder(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(orderDraftControllerProvider);
    final valid =
        ref.watch(draftSplitProvider.select((s) => s.isValid)) &&
        ref.watch(draftTeamIdProvider) != null &&
        draft.concept.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: AppButton(
        label: 'Registrar pedido',
        icon: Icons.check_rounded,
        busy: _busy,
        onPressed: valid ? _save : null,
      ),
    );
  }
}
