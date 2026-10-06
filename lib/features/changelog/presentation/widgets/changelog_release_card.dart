import 'package:flutter/material.dart';

import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../domain/changelog_note_type.dart';
import '../../domain/changelog_release.dart';
import '../release_date_label.dart';
import 'changelog_note_group.dart';

/// One release: its version and date, then its changes grouped by kind.
class ChangelogReleaseCard extends StatelessWidget {
  const new({required this.release, super.key});

  final ChangelogRelease release;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          'v${release.version} · ${releaseDateLabel(release.date)}',
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: AppRadii.mdRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: _Notes(release),
          ),
        ),
      ],
    );
  }
}

class _Notes extends StatelessWidget {
  const new(this.release);

  final ChangelogRelease release;

  @override
  Widget build(BuildContext context) {
    final groups = [
      for (final type in ChangelogNoteType.values)
        (
          type,
          [
            for (final n in release.notes)
              if (n.type == type) n,
          ],
        ),
    ].where((group) => group.$2.isNotEmpty);

    if (groups.isEmpty) {
      return Text(
        'Mejoras internas y de estabilidad.',
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (type, notes) in groups)
          ChangelogNoteGroup(type: type, notes: notes),
      ],
    );
  }
}
