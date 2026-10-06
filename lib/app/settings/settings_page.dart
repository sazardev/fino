import 'package:flutter/material.dart';

import '../../features/auth/presentation/widgets/profile_card.dart';
import '../../features/auth/presentation/widgets/sign_out_row.dart';
import '../../features/changelog/presentation/widgets/changelog_nav_tile.dart';
import '../../ui/atoms/app_switch.dart';
import '../../ui/molecules/section_header.dart';
import '../../ui/molecules/settings_nav_tile.dart';
import '../../ui/molecules/settings_row.dart';
import '../../ui/templates/settings_shell.dart';
import '../router/app_routes.dart';
import 'settings_scope.dart';
import 'signed_in_teams_section.dart';

/// Settings hub: one tile per settings screen.
class SettingsPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final haptics = SettingsScope.of(context).hapticsEnabled;

    return SettingsShell(
      children: [
        const ProfileCard(),
        const SignedInTeamsSection(),
        const SectionHeader('Preferencias'),
        SettingsNavTile(
          icon: Icons.palette_rounded,
          title: 'Apariencia',
          subtitle: 'Tema, color y tamaño',
          onTap: () => const AppearanceRoute().push<void>(context),
        ),
        SettingsNavTile(
          icon: Icons.widgets_rounded,
          title: 'Componentes',
          subtitle: 'Galería del sistema de diseño',
          onTap: () => const GalleryRoute().push<void>(context),
        ),
        ChangelogNavTile(
          onTap: () => const ChangelogRoute().push<void>(context),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: haptics,
          builder: (context, enabled, _) => SettingsRow(
            label: 'Vibración',
            subtitle: 'Respuesta háptica al tocar',
            trailing: AppSwitch(value: enabled, onChanged: haptics.update),
          ),
        ),
        const SignOutRow(),
      ],
    );
  }
}
