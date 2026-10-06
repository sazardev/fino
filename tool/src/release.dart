import 'conventional_commit.dart';

/// One classified commit inside a [Release].
class ReleaseNote {
  const new({
    required this.type,
    required this.subject,
    this.scope,
    this.breaking = false,
  });

  factory fromCommit(ConventionalCommit commit) => ReleaseNote(
    type: commit.type,
    scope: commit.scope,
    subject: commit.subject,
    breaking: commit.breaking,
  );

  factory fromJson(Map<String, dynamic> json) => ReleaseNote(
    type: CommitType.values.byName(json['type'] as String),
    scope: json['scope'] as String?,
    subject: json['subject'] as String,
    breaking: json['breaking'] as bool? ?? false,
  );

  final CommitType type;
  final String? scope;
  final String subject;
  final bool breaking;

  Map<String, dynamic> toJson() => {
    'type': type.name,
    if (scope != null) 'scope': scope,
    'subject': subject,
    if (breaking) 'breaking': true,
  };
}

/// Everything that shipped in one version. `assets/changelog.json` is a
/// newest-first list of these; `CHANGELOG.md` is rendered from the same list.
class Release {
  const new({required this.version, required this.date, required this.notes});

  factory fromJson(Map<String, dynamic> json) => Release(
    version: json['version'] as String,
    date: json['date'] as String,
    notes: [
      for (final note in json['notes'] as List<dynamic>)
        ReleaseNote.fromJson(note as Map<String, dynamic>),
    ],
  );

  final String version;

  /// ISO `yyyy-MM-dd`.
  final String date;
  final List<ReleaseNote> notes;

  Map<String, dynamic> toJson() => {
    'version': version,
    'date': date,
    'notes': [for (final note in notes) note.toJson()],
  };
}
