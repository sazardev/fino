import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/molecules/empty_state.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../providers/changelog_releases_provider.dart';
import '../widgets/changelog_release_card.dart';

/// Release history, newest first. No title: the settings tile already named it.
class ChangelogPage extends ConsumerWidget {
  const new({super.key, this.onBack});

  /// Where the back button leads; set by the route.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(changelogReleasesProvider)
        .when(
          loading: () =>
              SettingsShell(onBack: onBack, loaded: false, children: const []),
          error: (_, _) => SettingsShell(
            onBack: onBack,
            children: const [
              EmptyState(
                icon: Icons.error_outline_rounded,
                title: 'No se pudo cargar el historial',
              ),
            ],
          ),
          data: (releases) => SettingsShell(
            onBack: onBack,
            children: [
              if (releases.isEmpty)
                const EmptyState(
                  icon: Icons.auto_awesome_rounded,
                  title: 'Aún no hay versiones publicadas',
                  hint: 'Aquí aparecerá lo nuevo de cada versión.',
                ),
              for (final release in releases)
                ChangelogReleaseCard(release: release),
            ],
          ),
        );
  }
}
