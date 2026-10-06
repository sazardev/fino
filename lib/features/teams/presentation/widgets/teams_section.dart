import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/atoms/pop_in.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/molecules/settings_nav_tile.dart';
import '../navigation/teams_navigator_provider.dart';
import '../providers/user_teams_provider.dart';
import 'team_summary_subtitle.dart';

/// Mis equipos (cada uno lleva a su detalle) y cómo sumar otro: crearlo o
/// entrar con un código.
class TeamsSection extends ConsumerWidget {
  const new({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(userTeamsProvider(userId)).value ?? const [];
    final navigator = ref.read(teamsNavigatorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader('Equipos'),
        for (final (i, summary) in teams.indexed)
          PopIn(
            delay: Duration(milliseconds: 60 * i),
            child: SettingsNavTile(
              icon: Icons.groups_rounded,
              title: summary.team.name,
              subtitle: TeamSummarySubtitle.of(summary),
              onTap: () => navigator.openTeam(summary.team.id),
            ),
          ),
        SettingsNavTile(
          icon: Icons.group_add_rounded,
          title: 'Crear equipo',
          subtitle: 'Invita con un código',
          onTap: navigator.openCreateTeam,
        ),
        SettingsNavTile(
          icon: Icons.key_rounded,
          title: 'Entrar con código',
          subtitle: 'Únete al equipo que te invitó',
          onTap: navigator.openJoinTeam,
        ),
      ],
    );
  }
}
