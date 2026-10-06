import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/my_teams_provider.dart';
import '../../../../core/format/money_parser.dart';
import '../../../../ui/atoms/app_switch.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/choice_pill_row.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/molecules/settings_row.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../providers/draft_team_id_provider.dart';
import '../providers/order_draft_controller.dart';
import '../widgets/no_teams_state.dart';
import '../widgets/participants_section.dart';
import '../widgets/payout_required_banner.dart';
import '../widgets/save_order_button.dart';
import '../widgets/spent_at_choice.dart';
import '../widgets/split_summary.dart';

/// "Nuevo pedido": lo que pagué y quién me debe, con el reparto en vivo
/// (SPEC §5). Pantalla completa, sobre la navegación.
class OrderFormPage extends ConsumerStatefulWidget {
  const new({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  ConsumerState<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends ConsumerState<OrderFormPage> {
  @override
  Widget build(BuildContext context) {
    final teams = ref.watch(myTeamsProvider);
    final draft = ref.watch(orderDraftControllerProvider);
    final controller = ref.read(orderDraftControllerProvider.notifier);
    final list = teams.value ?? const [];
    final teamId = ref.watch(draftTeamIdProvider);

    return SettingsShell(
      title: 'Nuevo pedido',
      onBack: widget.onBack,
      loaded: teams.hasValue,
      children: [
        if (list.isEmpty || teamId == null)
          const NoTeamsState()
        else ...[
          if (list.length > 1)
            ChoicePillRow<String>(
              options: [for (final t in list) (t.id, t.name)],
              selected: teamId,
              onSelected: controller.selectTeam,
            ),
          PayoutRequiredBanner(teamId: teamId),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            maxLength: 80,
            textCapitalization: TextCapitalization.sentences,
            onChanged: controller.setConcept,
            decoration: const InputDecoration(
              labelText: '¿Qué fue?',
              hintText: 'Café, comida, taxi…',
            ),
          ),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (raw) => controller.setTotal(MoneyParser.parse(raw)),
            decoration: const InputDecoration(
              labelText: '¿Cuánto pagaste en total?',
              prefixText: r'$ ',
            ),
          ),
          const SectionHeader('¿Cuándo?'),
          SpentAtChoice(value: draft.spentAt, onChanged: controller.setSpentAt),
          const SectionHeader('¿Quién te debe?'),
          ParticipantsSection(teamId: teamId),
          SettingsRow(
            label: 'Yo también consumí',
            subtitle: 'Cuento como una parte más del reparto',
            trailing: AppSwitch(
              value: draft.creditorIncluded,
              onChanged: (_) => controller.toggleCreditorIncluded(),
            ),
          ),
          const SplitSummary(),
          TextField(
            maxLength: 200,
            onChanged: controller.setNote,
            decoration: const InputDecoration(labelText: 'Nota (opcional)'),
          ),
          const SaveOrderButton(),
        ],
      ],
    );
  }
}
