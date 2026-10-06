import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../ui/molecules/app_fab.dart';
import '../../ui/templates/navigation/app_destination.dart';
import '../../ui/templates/navigation/app_navigation_shell.dart';
import '../router/app_routes.dart';

/// The app's frame: three destinations, each with its own navigation stack
/// (the router's branches).
class AppShell extends StatelessWidget {
  const new({required this.navigationShell, required this.branches, super.key});

  final StatefulNavigationShell navigationShell;

  /// One navigator per destination, in destination order.
  final List<Widget> branches;

  static const _destinations = [
    AppDestination(icon: Icons.home_rounded, label: 'Inicio'),
    AppDestination(icon: Icons.widgets_rounded, label: 'Componentes'),
    AppDestination(icon: Icons.tune_rounded, label: 'Ajustes'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppNavigationShell(
      destinations: _destinations,
      pages: branches,
      index: navigationShell.currentIndex,
      onSelect: navigationShell.goBranch,
      onReselect: (i) => navigationShell.goBranch(i, initialLocation: true),
      // Forms open full screen, above the navigation, so they don't compete
      // with the keyboard.
      fab: navigationShell.currentIndex == 0
          ? AppFab(
              icon: Icons.add_rounded,
              label: 'Nuevo',
              onPressed: () => const ComposeRoute().push<void>(context),
            )
          : null,
    );
  }
}
