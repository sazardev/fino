import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../ui/molecules/settings_nav_tile.dart';
import '../providers/changelog_releases_provider.dart';

/// Settings tile that opens the changelog, showing the current version.
class ChangelogNavTile extends ConsumerWidget {
  const new({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(
      changelogReleasesProvider.select((r) => r.value?.firstOrNull?.version),
    );

    return SettingsNavTile(
      icon: Icons.auto_awesome_rounded,
      title: 'Novedades',
      subtitle: version == null ? 'Historial de versiones' : 'Versión $version',
      onTap: onTap,
    );
  }
}
