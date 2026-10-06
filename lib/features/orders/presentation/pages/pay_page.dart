import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/directory_person.dart';
import '../../../../core/directory/payout_provider.dart';
import '../../../../core/directory/people_provider.dart';
import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../providers/pay_selection_provider.dart';
import '../widgets/pay_confirm_section.dart';
import '../widgets/payable_debt_tile.dart';
import '../widgets/payout_card.dart';

/// *Pagar*: la cuenta del acreedor para copiar, qué deudas incluye este pago
/// y el "Ya pagué" (SPEC §6.3). Pantalla completa: es un flujo de captura.
class PayPage extends ConsumerWidget {
  const new({
    required this.teamId,
    required this.creditorId,
    super.key,
    this.onBack,
  });

  final String teamId;
  final String creditorId;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = DirectoryPerson.keyOf(teamId, creditorId);
    final name = ref.watch(
      peopleProvider.select((p) => p.value?[key]?.displayName ?? 'Alguien'),
    );
    final payout = ref.watch(payoutProvider(teamId, creditorId));
    final selection = ref.watch(paySelectionProvider(teamId, creditorId));
    final payable = selection.value?.payable ?? const [];

    return SettingsShell(
      title: 'Pagar a $name',
      onBack: onBack,
      loaded: selection.hasValue,
      children: [
        if (payable.isEmpty)
          EmptyState(
            icon: Icons.task_alt_rounded,
            title: 'Nada por pagar',
            hint: 'No tienes deudas pendientes con $name.',
          )
        else ...[
          PayoutCard(payout: payout.value, name: name),
          const SectionHeader('Qué pagas'),
          for (final debt in payable)
            PayableDebtTile(
              debt: debt,
              selected: !selection.requireValue.excluded.contains(debt.id),
            ),
          PayConfirmSection(
            selected: selection.requireValue.selected,
            creditorName: name,
            canReport: payout.value != null,
            onDone: onBack,
          ),
        ],
      ],
    );
  }
}
