import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/confirm_action_row.dart';
import '../../domain/entities/team_member.dart';
import '../providers/commands/expel_member_command_provider.dart';
import '../providers/commands/transfer_admin_command_provider.dart';
import '../text/describe_team_error.dart';

/// Lo que el admin puede hacer con un miembro, confirmado en el lugar.
class MemberAdminActions extends ConsumerWidget {
  const new({required this.member, super.key});

  final TeamMember member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(sessionUserIdProvider)!;
    final name = member.displayName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ConfirmActionRow(
          icon: Icons.admin_panel_settings_rounded,
          label: 'Hacer admin a $name',
          confirmLabel: 'Confirmar: pasarle el rol',
          hint: 'Tú quedas como miembro',
          onConfirmed: () => runAction(
            context,
            () => ref.read(transferAdminCommandProvider)(
              actorId: me,
              teamId: member.teamId,
              targetUserId: member.userId,
            ),
            success: '$name ahora es admin',
            describe: describeTeamError,
          ),
        ),
        ConfirmActionRow(
          icon: Icons.person_remove_rounded,
          label: 'Expulsar a $name',
          confirmLabel: 'Confirmar: expulsar',
          hint: 'Solo si no tiene deudas vivas en el equipo',
          onConfirmed: () => runAction(
            context,
            () => ref.read(expelMemberCommandProvider)(
              actorId: me,
              teamId: member.teamId,
              targetUserId: member.userId,
            ),
            success: '$name salió del equipo',
            describe: describeTeamError,
          ),
        ),
      ],
    );
  }
}
