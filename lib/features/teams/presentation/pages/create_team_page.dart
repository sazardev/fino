import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_profile_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../navigation/teams_navigator_provider.dart';
import '../providers/commands/create_team_command_provider.dart';
import '../text/describe_team_error.dart';

/// "Nuevo equipo": un nombre y listo; quien lo crea queda como admin (E1).
class CreateTeamPage extends ConsumerStatefulWidget {
  const new({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  ConsumerState<CreateTeamPage> createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends ConsumerState<CreateTeamPage> {
  final _name = TextEditingController();
  var _busy = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final profile = ref.read(sessionProfileProvider);
    if (profile == null) return;
    setState(() => _busy = true);
    String? created;
    await runAction(
      context,
      () async {
        final team = await ref.read(createTeamCommandProvider)(
          userId: profile.uid,
          name: _name.text,
          displayName: profile.displayName,
          photoUrl: profile.photoUrl,
        );
        created = team.id;
      },
      success: 'Equipo creado: comparte su código',
      describe: describeTeamError,
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (created case final id?) ref.read(teamsNavigatorProvider).showTeam(id);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsShell(
      title: 'Nuevo equipo',
      onBack: widget.onBack,
      children: [
        TextField(
          controller: _name,
          autofocus: true,
          maxLength: 50,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (_) => _create(),
          decoration: const InputDecoration(
            labelText: 'Nombre del equipo',
            hintText: 'Oficina, Los del café…',
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Crear equipo',
          icon: Icons.check_rounded,
          busy: _busy,
          onPressed: _create,
        ),
      ],
    );
  }
}
