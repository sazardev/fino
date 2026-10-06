import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../providers/debtor_candidates_provider.dart';
import '../widgets/add_debtor_form.dart';

/// "Agregar a alguien" a un pedido abierto (SPEC §5.5).
class AddDebtorPage extends ConsumerWidget {
  const new({required this.orderId, super.key, this.onBack});

  final String orderId;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final candidates = ref.watch(debtorCandidatesProvider(orderId));
    final list = candidates.value ?? const [];

    return SettingsShell(
      title: 'Agregar a alguien',
      onBack: onBack,
      loaded: candidates.hasValue,
      children: [
        if (list.isEmpty)
          const EmptyState(
            icon: Icons.groups_rounded,
            title: 'Ya están todos',
            hint: 'Todo el equipo ya está en este pedido.',
          )
        else
          AddDebtorForm(orderId: orderId, candidates: list, onDone: onBack),
      ],
    );
  }
}
