import 'dart:convert';

import 'package:fino/features/changelog/data/asset_changelog_repository.dart';
import 'package:fino/features/changelog/domain/changelog_note.dart';
import 'package:fino/features/changelog/domain/changelog_note_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _Bundle extends AssetBundle {
  new(this._json);

  final String _json;

  @override
  Future<ByteData> load(String key) {
    final bytes = Uint8List.fromList(utf8.encode(_json));
    return SynchronousFuture(ByteData.sublistView(bytes));
  }
}

const _json = '''
[
  {"version": "0.2.0", "date": "2026-10-06", "notes": [
    {"type": "feat", "scope": "auth", "subject": "add login"},
    {"type": "chore", "subject": "bump deps"},
    {"type": "perf", "subject": "faster list"},
    {"type": "fix", "subject": "keep session"}
  ]},
  {"version": "0.1.0", "date": "2026-10-01", "notes": []}
]
''';

void main() {
  test('reads releases in file order, newest first', () async {
    final releases = await AssetChangelogRepository(_Bundle(_json))
        .loadReleases();

    expect(releases.map((r) => r.version), ['0.2.0', '0.1.0']);
    expect(releases.first.date, DateTime(2026, 10, 6));
  });

  test(
    'keeps only feat, fix and perf, as feature, fix and improvement',
    () async {
      final releases = await AssetChangelogRepository(_Bundle(_json))
          .loadReleases();

      expect(releases.first.notes, const [
        ChangelogNote(
          type: ChangelogNoteType.feature,
          scope: 'auth',
          subject: 'add login',
        ),
        ChangelogNote(
          type: ChangelogNoteType.improvement,
          subject: 'faster list',
        ),
        ChangelogNote(type: ChangelogNoteType.fix, subject: 'keep session'),
      ]);
      expect(releases.last.notes, isEmpty);
    },
  );

  test('an empty file is an empty history', () async {
    final releases = await AssetChangelogRepository(_Bundle('[]'))
        .loadReleases();
    expect(releases, isEmpty);
  });
}
