import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/molecules/settings_nav_tile.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../../domain/enums/team_role.dart';
import '../navigation/teams_navigator_provider.dart';
import '../providers/my_payout_method_provider.dart';
import '../providers/team_members_provider.dart';
import '../providers/team_provider.dart';
import '../text/payout_method_label.dart';
import '../widgets/invite_code_card.dart';
import '../widgets/member_tile.dart';
import '../widgets/team_exit_actions.dart';

/// Un equipo: su código para invitar, mi cuenta de cobro, quiénes son y, al
/// final, salir o eliminarlo. Su nombre es el título.
class TeamDetailPage extends ConsumerWidget {
  const new({required this.teamId, super.key, this.onBack});

  final String teamId;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(sessionUserIdProvider);
    final team = ref.watch(teamProvider(teamId));
    final members = ref.watch(teamMembersProvider(teamId)).value ?? const [];
    final payout = ref.watch(myPayoutMethodProvider(teamId));
    final found = team.value;
    final iAmAdmin = members.any(
      (m) => m.userId == me && m.role == TeamRole.admin,
    );

    return SettingsShell(
      title: found?.name,
      onBack: onBack,
      loaded: team.hasValue,
      children: [
        if (found == null)
          const EmptyState(
            icon: Icons.group_off_rounded,
            title: 'Ya no estás en este equipo',
          )
        else ...[
          InviteCodeCard(team: found, isAdmin: iAmAdmin),
          const SectionHeader('Tu cuenta de cobro'),
          SettingsNavTile(
            icon: Icons.account_balance_rounded,
            title: payout.value == null ? 'Configurar' : 'Cambiar',
            subtitle: PayoutMethodLabel.of(payout.value),
            onTap: () =>
                ref.read(teamsNavigatorProvider).openPayoutSetup(teamId),
          ),
          SectionHeader('Miembros (${members.length})'),
          for (final member in members)
            MemberTile(member: member, iAmAdmin: iAmAdmin),
          const SectionHeader('Equipo'),
          TeamExitActions(teamId: teamId, iAmAdmin: iAmAdmin),
        ],
      ],
    );
  }
}
