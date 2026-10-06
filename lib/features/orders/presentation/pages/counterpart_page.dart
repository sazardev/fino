import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/directory_person.dart';
import '../../../../core/directory/people_provider.dart';
import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../providers/counterpart_balance_provider.dart';
import '../widgets/counterpart_actions.dart';
import '../widgets/counterpart_debt_line.dart';

/// Mis cuentas con una persona en un equipo: lo que le debo, lo que me debe y
/// qué hacer al respecto. Su nombre es el título: aporta (DESIGN §0.1).
class CounterpartPage extends ConsumerWidget {
  const new({
    required this.teamId,
    required this.userId,
    super.key,
    this.onBack,
  });

  final String teamId;
  final String userId;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = DirectoryPerson.keyOf(teamId, userId);
    final name = ref.watch(
      peopleProvider.select((p) => p.value?[key]?.displayName),
    );
    final balance = ref.watch(counterpartBalanceProvider(teamId, userId));
    final iOwe = balance.value?.iOwe;
    final owedToMe = balance.value?.owedToMe;

    return SettingsShell(
      title: name ?? 'Cuentas',
      onBack: onBack,
      loaded: balance.hasValue,
      children: [
        if (iOwe == null || owedToMe == null)
          const SizedBox.shrink()
        else ...[
          if (balance.requireValue.isEmpty)
            const EmptyState(
              icon: Icons.handshake_rounded,
              title: 'Están a mano',
              hint: 'No hay nada pendiente entre ustedes.',
            ),
          if (iOwe.debts.isNotEmpty) ...[
            const SectionHeader('Le debes'),
            for (final debt in iOwe.debts)
              CounterpartDebtLine(debt: debt, iAmCreditor: false),
          ],
          if (owedToMe.debts.isNotEmpty) ...[
            const SectionHeader('Te debe'),
            for (final debt in owedToMe.debts)
              CounterpartDebtLine(debt: debt, iAmCreditor: true),
          ],
          CounterpartActions(iOwe: iOwe, owedToMe: owedToMe),
        ],
      ],
    );
  }
}
