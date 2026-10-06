import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/directory/my_teams_provider.dart';
import '../../features/inbox/presentation/providers/unread_count_provider.dart';
import '../../ui/molecules/app_fab.dart';
import '../../ui/templates/navigation/app_destination.dart';
import '../../ui/templates/navigation/app_navigation_shell.dart';
import '../router/app_routes.dart';

/// The app's frame: four destinations, each with its own navigation stack
/// (the router's branches). "Buzón" carries the unread count.
class AppShell extends ConsumerWidget {
  const new({required this.navigationShell, required this.branches, super.key});

  final StatefulNavigationShell navigationShell;

  /// One navigator per destination, in destination order.
  final List<Widget> branches;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadCountProvider).value ?? 0;
    final hasTeams = ref.watch(
      myTeamsProvider.select((t) => t.value?.isNotEmpty ?? false),
    );
    final index = navigationShell.currentIndex;

    return AppNavigationShell(
      destinations: [
        const AppDestination(icon: Icons.home_rounded, label: 'Inicio'),
        const AppDestination(
          icon: Icons.receipt_long_rounded,
          label: 'Pedidos',
        ),
        AppDestination(
          icon: Icons.inbox_rounded,
          label: 'Buzón',
          badge: unread,
        ),
        const AppDestination(icon: Icons.tune_rounded, label: 'Ajustes'),
      ],
      pages: branches,
      index: index,
      // Every tap on the bar lands on the destination's root: a subscreen left
      // open (Ajustes → Apariencia) must not be waiting when coming back.
      onSelect: (i) => navigationShell.goBranch(i, initialLocation: true),
      onReselect: (i) => navigationShell.goBranch(i, initialLocation: true),
      // The one primary action: a new order, from Inicio and Pedidos. The form
      // opens full screen, above the navigation.
      fab: hasTeams && index <= 1
          ? AppFab(
              icon: Icons.add_rounded,
              label: 'Nuevo pedido',
              onPressed: () => const NewOrderRoute().push<void>(context),
            )
          : null,
    );
  }
}
