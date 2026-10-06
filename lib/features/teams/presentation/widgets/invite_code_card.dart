import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/confirm_action_row.dart';
import '../../../../ui/molecules/copy_value_tile.dart';
import '../../domain/entities/team.dart';
import '../providers/commands/regenerate_invite_code_command_provider.dart';
import '../text/describe_team_error.dart';

/// El código para invitar (SPEC E2): para copiar y compartir. El admin puede
/// cambiarlo; el anterior deja de servir (E3).
class InviteCodeCard extends ConsumerWidget {
  const new({required this.team, required this.isAdmin, super.key});

  final Team team;
  final bool isAdmin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = team.inviteCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CopyValueTile(
          label: 'Código para invitar',
          value: code,
          display: '${code.substring(0, 4)} ${code.substring(4)}',
          copiedMessage: 'Código copiado: compártelo con tu equipo',
        ),
        if (isAdmin)
          ConfirmActionRow(
            icon: Icons.autorenew_rounded,
            label: 'Cambiar código',
            confirmLabel: 'Confirmar: cambiar código',
            hint: 'El código actual dejará de servir',
            onConfirmed: () => runAction(
              context,
              () => ref.read(regenerateInviteCodeCommandProvider)(
                actorId: ref.read(sessionUserIdProvider)!,
                teamId: team.id,
              ),
              success: 'Código nuevo listo',
              describe: describeTeamError,
            ),
          ),
      ],
    );
  }
}
