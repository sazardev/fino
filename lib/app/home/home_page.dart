import 'package:flutter/material.dart';

import '../../ui/atoms/app_icon_button.dart';
import '../../ui/brand/fino_mark.dart';
import '../../ui/molecules/switching_icon_button.dart';
import '../../ui/navigation/app_page_route.dart';
import '../../ui/templates/floating_actions/floating_actions_shell.dart';
import '../settings/settings_page.dart';

/// Placeholder home: shows the layout shell with its floating controls. Real
/// content goes in `body`.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _active = false;

  void _openSettings() =>
      Navigator.of(context).push(appPageRoute((_) => const SettingsPage()));

  @override
  Widget build(BuildContext context) {
    return FloatingActionsShell(
      body: Center(
        child: FinoMark(progress: const AlwaysStoppedAnimation(1), size: 160),
      ),
      actions: [
        AppIconButton(
          tooltip: 'Ajustes',
          onPressed: _openSettings,
          icon: const Icon(Icons.tune_rounded),
        ),
      ],
      primaryAction: SwitchingIconButton(
        active: _active,
        activeIcon: Icons.close_rounded,
        inactiveIcon: Icons.add_rounded,
        tooltip: _active ? 'Cerrar' : 'Agregar',
        autofocus: true,
        onPressed: () => setState(() => _active = !_active),
      ),
    );
  }
}
