import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_profile_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../navigation/teams_navigator_provider.dart';
import '../providers/commands/join_team_command_provider.dart';
import '../text/describe_team_error.dart';

/// Entrar a un equipo con el código que te compartieron (SPEC E2). Llega
/// prellenado si se abrió desde un enlace de invitación.
class JoinTeamPage extends ConsumerStatefulWidget {
  const new({super.key, this.code, this.onBack});

  final String? code;
  final VoidCallback? onBack;

  @override
  ConsumerState<JoinTeamPage> createState() => _JoinTeamPageState();
}

class _JoinTeamPageState extends ConsumerState<JoinTeamPage> {
  late final _code = TextEditingController(text: widget.code ?? '');
  var _busy = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _join() async {
    final profile = ref.read(sessionProfileProvider);
    if (profile == null) return;
    setState(() => _busy = true);
    String? joined;
    await runAction(
      context,
      () async {
        final team = await ref.read(joinTeamCommandProvider)(
          userId: profile.uid,
          displayName: profile.displayName,
          photoUrl: profile.photoUrl,
          code: _code.text,
        );
        joined = team.id;
      },
      success: '¡Listo! Ya eres parte del equipo',
      describe: describeTeamError,
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (joined case final id?) ref.read(teamsNavigatorProvider).showTeam(id);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsShell(
      title: 'Entrar con código',
      onBack: widget.onBack,
      children: [
        TextField(
          controller: _code,
          autofocus: widget.code == null,
          maxLength: 9,
          textCapitalization: TextCapitalization.characters,
          onSubmitted: (_) => _join(),
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(letterSpacing: 4, fontWeight: FontWeight.w700),
          decoration: const InputDecoration(
            labelText: 'Código del equipo',
            hintText: 'ABCD 2345',
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Entrar al equipo',
          icon: Icons.login_rounded,
          busy: _busy,
          onPressed: _join,
        ),
      ],
    );
  }
}
