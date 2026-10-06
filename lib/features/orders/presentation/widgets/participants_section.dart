import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/team_people_provider.dart';
import '../../../../core/format/money_parser.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/molecules/inline_editor.dart';
import '../providers/draft_split_provider.dart';
import '../providers/order_draft_controller.dart';
import 'participant_tile.dart';

/// "¿Quién te debe?": los miembros del equipo; los elegidos muestran su parte
/// y se pueden fijar a mano. Vaciar el monto fijo lo devuelve al reparto.
class ParticipantsSection extends ConsumerStatefulWidget {
  const new({required this.teamId, super.key});

  final String teamId;

  @override
  ConsumerState<ParticipantsSection> createState() =>
      _ParticipantsSectionState();
}

class _ParticipantsSectionState extends ConsumerState<ParticipantsSection> {
  String? _fixing;

  @override
  Widget build(BuildContext context) {
    final me = ref.watch(sessionUserIdProvider);
    final people = ref.watch(teamPeopleProvider(widget.teamId)).value ?? [];
    final draft = ref.watch(orderDraftControllerProvider);
    final split = ref.watch(draftSplitProvider);
    final controller = ref.read(orderDraftControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final person in people)
          if (person.userId != me)
            if (_fixing == person.userId)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InlineEditor(
                  label: 'Monto fijo de ${person.displayName}',
                  hint: 'Vacío = parte igual',
                  saveLabel: 'Fijar',
                  prefixText: r'$ ',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  initial: switch (draft.fixed[person.userId]) {
                    final amount? => MoneyParser.editable(amount),
                    null => '',
                  },
                  onSave: (raw) async {
                    controller.setFixed(person.userId, MoneyParser.parse(raw));
                    setState(() => _fixing = null);
                  },
                  onCancel: () => setState(() => _fixing = null),
                ),
              )
            else
              ParticipantTile(
                person: person,
                selected: draft.participants.contains(person.userId),
                fixed: draft.fixed.containsKey(person.userId),
                amount: split.amounts[person.userId],
                onToggle: () => controller.toggleParticipant(person.userId),
                onEditAmount: () => setState(() => _fixing = person.userId),
              ),
      ],
    );
  }
}
