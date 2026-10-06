import 'package:flutter/material.dart';

import '../../ui/molecules/app_fab.dart';
import '../../ui/templates/navigation/app_destination.dart';
import '../../ui/templates/navigation/app_navigation_shell.dart';
import '../../ui/navigation/app_page_route.dart';
import '../gallery/gallery_page.dart';
import '../home/compose_page.dart';
import '../home/home_page.dart';
import '../settings/settings_page.dart';
import 'destination_navigator.dart';

/// The app's frame: three destinations, each with its own navigation stack.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  static const _destinations = [
    AppDestination(icon: Icons.home_rounded, label: 'Inicio'),
    AppDestination(icon: Icons.widgets_rounded, label: 'Componentes'),
    AppDestination(icon: Icons.tune_rounded, label: 'Ajustes'),
  ];

  final _keys = List.generate(3, (_) => GlobalKey<NavigatorState>());
  late final _pages = [
    DestinationNavigator(navigatorKey: _keys[0], root: const HomePage()),
    DestinationNavigator(navigatorKey: _keys[1], root: const GalleryPage()),
    DestinationNavigator(navigatorKey: _keys[2], root: const SettingsPage()),
  ];

  int _index = 0;

  /// Forms open full screen, above the navigation, so they don't compete with
  /// the keyboard.
  void _compose() => Navigator.of(
    context,
    rootNavigator: true,
  ).push(appPageRoute((_) => const ComposePage()));

  @override
  Widget build(BuildContext context) {
    return AppNavigationShell(
      destinations: _destinations,
      pages: _pages,
      index: _index,
      onSelect: (i) => setState(() => _index = i),
      onReselect: (i) =>
          _keys[i].currentState?.popUntil((route) => route.isFirst),
      fab: _index == 0
          ? AppFab(icon: Icons.add_rounded, label: 'Nuevo', onPressed: _compose)
          : null,
    );
  }
}
