import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/molecules/app_button_tone.dart';
import '../../../../ui/molecules/empty_state.dart';
import '../navigation/orders_navigator_provider.dart';

/// Lo primero que ve alguien nuevo: Fino funciona en equipo (SPEC §4).
class NoTeamsState extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = ref.read(ordersNavigatorProvider);

    return Column(
      children: [
        const EmptyState(
          icon: Icons.groups_rounded,
          title: 'Empieza con tu equipo',
          hint:
              'Crea uno e invita con su código, o entra con el código que te '
              'compartieron.',
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            AppButton(
              label: 'Crear equipo',
              icon: Icons.add_rounded,
              onPressed: navigator.openCreateTeam,
            ),
            AppButton(
              label: 'Tengo un código',
              icon: Icons.key_rounded,
              tone: AppButtonTone.tonal,
              onPressed: navigator.openJoinTeam,
            ),
          ],
        ),
      ],
    );
  }
}
