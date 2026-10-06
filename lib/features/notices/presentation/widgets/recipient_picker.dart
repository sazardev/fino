import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/team_people_provider.dart';
import '../../../../core/format/money_format.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/atoms/choice_pill.dart';
import '../../../../ui/design/app_spacing.dart';
import '../providers/owed_to_me_provider.dart';

/// A quién avisar: cualquiera del equipo; un atajo para "todos los que me
/// deben", que además muestran cuánto (SPEC A1).
class RecipientPicker extends ConsumerWidget {
  const new({
    required this.teamId,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final String teamId;
  final Set<String> selected;
  final ValueChanged<Set<String>> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(sessionUserIdProvider);
    final people = ref.watch(teamPeopleProvider(teamId)).value ?? const [];
    final owed = ref.watch(owedToMeProvider(teamId)).value ?? const {};
    final debtors = owed.keys.toSet();

    void toggle(String id) => onChanged(
      selected.contains(id) ? ({...selected}..remove(id)) : {...selected, id},
    );

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        if (debtors.isNotEmpty)
          ChoicePill(
            label: 'Todos los que me deben',
            icon: Icons.group_rounded,
            selected:
                selected.length == debtors.length &&
                selected.containsAll(debtors),
            onTap: () => onChanged(debtors),
          ),
        for (final person in people)
          if (person.userId != me)
            ChoicePill(
              label: switch (owed[person.userId]) {
                final amount? =>
                  '${person.displayName} · ${MoneyFormat.format(amount)}',
                null => person.displayName,
              },
              selected: selected.contains(person.userId),
              onTap: () => toggle(person.userId),
            ),
      ],
    );
  }
}
