import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/my_teams_provider.dart';
import '../../../../ui/atoms/pop_in.dart';
import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../providers/balance_view_provider.dart';
import '../widgets/balance_header.dart';
import '../widgets/confirm_queue_tile.dart';
import '../widgets/no_teams_state.dart';
import '../widgets/person_balance_tile.dart';

/// Inicio: cuánto me deben, cuánto debo y con quién. Sin título: la
/// navegación ya dice "Inicio".
class BalancePage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(myTeamsProvider);
    final view = ref.watch(balanceViewProvider);
    final hasTeams = teams.value?.isNotEmpty ?? false;

    return SettingsShell(
      loaded: teams.hasValue && (view.hasValue || !hasTeams),
      children: [
        if (!hasTeams)
          const NoTeamsState()
        else if (view.value case final view?) ...[
          BalanceHeader(view: view),
          if (view.toConfirm.isNotEmpty) ...[
            const SectionHeader('Por confirmar'),
            for (final balance in view.toConfirm)
              ConfirmQueueTile(balance: balance),
          ],
          if (view.isEmpty)
            const EmptyState(
              icon: Icons.celebration_rounded,
              title: 'Todo fino',
              hint: 'No debes nada y nadie te debe.',
            ),
          if (view.iOwe.isNotEmpty) const SectionHeader('Debes'),
          for (final (i, balance) in view.iOwe.indexed)
            PopIn(
              delay: Duration(milliseconds: 60 * i),
              child: PersonBalanceTile(balance: balance, owedToMe: false),
            ),
          if (view.owedToMe.isNotEmpty) const SectionHeader('Te deben'),
          for (final (i, balance) in view.owedToMe.indexed)
            PopIn(
              delay: Duration(milliseconds: 60 * i),
              child: PersonBalanceTile(balance: balance, owedToMe: true),
            ),
        ],
      ],
    );
  }
}
