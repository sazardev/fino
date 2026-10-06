import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/templates/settings_shell.dart';
import '../providers/my_payout_method_provider.dart';
import '../widgets/payout_method_form.dart';

/// "Cuenta de cobro": a dónde me pagan en este equipo (SPEC M1–M5).
class PayoutMethodPage extends ConsumerWidget {
  const new({required this.teamId, super.key, this.onBack});

  final String teamId;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(myPayoutMethodProvider(teamId));

    return SettingsShell(
      title: 'Cuenta de cobro',
      onBack: onBack,
      loaded: current.hasValue,
      children: [
        if (current.hasValue)
          PayoutMethodForm(
            teamId: teamId,
            current: current.value,
            onDone: onBack,
          ),
      ],
    );
  }
}
