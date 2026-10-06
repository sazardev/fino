import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/payout_provider.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/molecules/settings_nav_tile.dart';
import '../navigation/orders_navigator_provider.dart';

/// Sin cuenta de cobro no hay pedidos (SPEC M2): avisa y lleva a configurarla.
class PayoutRequiredBanner extends ConsumerWidget {
  const new({required this.teamId, super.key});

  final String teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(sessionUserIdProvider) ?? '';
    final payout = ref.watch(payoutProvider(teamId, me));
    if (!payout.hasValue || payout.value != null) {
      return const SizedBox.shrink();
    }
    return SettingsNavTile(
      icon: Icons.account_balance_rounded,
      title: 'Configura tu cuenta de cobro',
      subtitle: 'Sin ella nadie sabría a dónde pagarte',
      onTap: () => ref.read(ordersNavigatorProvider).openPayoutSetup(teamId),
    );
  }
}
