import 'package:flutter/material.dart';

import '../../../../ui/design/app_spacing.dart';
import '../../domain/changelog_note.dart';
import '../../domain/changelog_note_type.dart';

/// The notes of one kind inside a release: a small label and a bullet each.
class ChangelogNoteGroup extends StatelessWidget {
  const new({required this.type, required this.notes, super.key});

  final ChangelogNoteType type;
  final List<ChangelogNote> notes;

  static String labelOf(ChangelogNoteType type) => switch (type) {
    ChangelogNoteType.feature => 'Novedades',
    ChangelogNoteType.fix => 'Correcciones',
    ChangelogNoteType.improvement => 'Mejoras',
  };

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelOf(type),
          style: text.labelMedium?.copyWith(
            color: muted,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        for (final note in notes)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('•  ', style: text.bodyMedium?.copyWith(color: muted)),
                Expanded(child: _NoteText(note)),
              ],
            ),
          ),
      ],
    );
  }
}

class _NoteText extends StatelessWidget {
  const new(this.note);

  final ChangelogNote note;

  @override
  Widget build(BuildContext context) {
    final scope = note.scope;

    return Text.rich(
      TextSpan(
        children: [
          if (scope != null)
            TextSpan(
              text: '$scope: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          TextSpan(text: note.subject),
        ],
      ),
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
