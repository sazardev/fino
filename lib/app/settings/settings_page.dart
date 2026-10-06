import 'package:flutter/material.dart';

import '../../ui/atoms/app_switch.dart';
import '../../ui/molecules/settings_nav_tile.dart';
import '../../ui/molecules/settings_row.dart';
import '../../ui/navigation/app_page_route.dart';
import '../../ui/templates/settings_shell.dart';
import '../gallery/gallery_page.dart';
import 'appearance_page.dart';
import 'settings_scope.dart';

/// Settings hub: one tile per settings screen.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _open(BuildContext context, Widget page) =>
      Navigator.of(context).push(appPageRoute((_) => page));

  @override
  Widget build(BuildContext context) {
    final haptics = SettingsScope.of(context).hapticsEnabled;

    return SettingsShell(
      title: 'Ajustes',
      children: [
        SettingsNavTile(
          icon: Icons.palette_rounded,
          title: 'Apariencia',
          subtitle: 'Tema, color y tamaño',
          onTap: () => _open(context, const AppearancePage()),
        ),
        SettingsNavTile(
          icon: Icons.widgets_rounded,
          title: 'Componentes',
          subtitle: 'Galería del sistema de diseño',
          onTap: () => _open(context, const GalleryPage()),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: haptics,
          builder: (context, enabled, _) => SettingsRow(
            label: 'Vibración',
            subtitle: 'Respuesta háptica al tocar',
            trailing: AppSwitch(value: enabled, onChanged: haptics.update),
          ),
        ),
      ],
    );
  }
}
