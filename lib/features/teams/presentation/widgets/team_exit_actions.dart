import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/confirm_action_row.dart';
import '../navigation/teams_navigator_provider.dart';
import '../providers/commands/delete_team_command_provider.dart';
import '../providers/commands/leave_team_command_provider.dart';
import '../text/describe_team_error.dart';

/// Salir del equipo (miembros) o eliminarlo (admin). Las deudas vivas lo
/// impiden y el mensaje dice cuáles (SPEC §4.2).
class TeamExitActions extends ConsumerWidget {
  const new({required this.teamId, required this.iAmAdmin, super.key});

  final String teamId;
  final bool iAmAdmin;

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function(String me) action,
    String success,
  ) async {
    final ok = await runAction(
      context,
      () => action(ref.read(sessionUserIdProvider)!),
      success: success,
      describe: describeTeamError,
    );
    if (ok) ref.read(teamsNavigatorProvider).showSettings();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (iAmAdmin) {
      return ConfirmActionRow(
        icon: Icons.delete_forever_rounded,
        label: 'Eliminar equipo',
        confirmLabel: 'Confirmar: eliminar equipo',
        hint: 'Para salir sin eliminarlo, pasa antes el rol de admin',
        onConfirmed: () => _run(
          context,
          ref,
          (me) =>
              ref.read(deleteTeamCommandProvider)(actorId: me, teamId: teamId),
          'Equipo eliminado',
        ),
      );
    }
    return ConfirmActionRow(
      icon: Icons.logout_rounded,
      label: 'Salir del equipo',
      confirmLabel: 'Confirmar: salir',
      hint: 'Solo si no tienes deudas vivas en el equipo',
      onConfirmed: () => _run(
        context,
        ref,
        (me) => ref.read(leaveTeamCommandProvider)(userId: me, teamId: teamId),
        'Saliste del equipo',
      ),
    );
  }
}
