import '../domain/changelog_note.dart';
import '../domain/changelog_note_type.dart';
import '../domain/changelog_release.dart';

const Map<String, ChangelogNoteType> _typesByCommit = {
  'feat': ChangelogNoteType.feature,
  'fix': ChangelogNoteType.fix,
  'perf': ChangelogNoteType.improvement,
};

/// Maps one entry of `assets/changelog.json` to a release, keeping only the
/// notes a user cares about (the file also stores chores, docs, refactors…).
ChangelogRelease releaseFromJson(Map<String, dynamic> json) => ChangelogRelease(
  version: json['version'] as String,
  date: DateTime.parse(json['date'] as String),
  notes: [
    for (final entry in json['notes'] as List<dynamic>)
      ?_noteFromJson(entry as Map<String, dynamic>),
  ],
);

ChangelogNote? _noteFromJson(Map<String, dynamic> json) {
  final type = _typesByCommit[json['type']];
  if (type == null) return null;
  return ChangelogNote(
    type: type,
    scope: json['scope'] as String?,
    subject: json['subject'] as String,
  );
}
