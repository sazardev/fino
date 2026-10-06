import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/molecules/confirm_action_row.dart';
import '../providers/sign_out_controller.dart';

/// Settings row that signs out, after a confirmation in place.
class SignOutRow extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConfirmActionRow(
      icon: Icons.logout_rounded,
      label: 'Cerrar sesión',
      confirmLabel: 'Confirmar: cerrar sesión',
      hint: 'Se borran los datos guardados en este dispositivo.',
      onConfirmed: ref.read(signOutControllerProvider.notifier).signOut,
    );
  }
}
