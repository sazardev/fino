import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/changelog_markdown.dart';
import '../../tool/src/conventional_commit.dart';
import '../../tool/src/release.dart';

const _release = Release(
  version: '0.2.0',
  date: '2026-10-06',
  notes: [
    ReleaseNote(type: CommitType.chore, subject: 'bump deps'),
    ReleaseNote(type: CommitType.fix, scope: 'auth', subject: 'keep session'),
    ReleaseNote(type: CommitType.feat, subject: 'add changelog'),
    ReleaseNote(type: CommitType.perf, subject: 'faster list'),
    ReleaseNote(type: CommitType.feat, subject: 'new API', breaking: true),
  ],
);

void main() {
  test('groups notes in a fixed order, scope in bold', () {
    expect(renderRelease(_release), '''
## v0.2.0 - 2026-10-06

### Breaking changes

- new API

### Added

- add changelog

### Fixed

- **auth:** keep session

### Changed

- faster list

### Other

- bump deps
''');
  });

  test('omits sections without notes', () {
    const release = Release(
      version: '0.1.1',
      date: '2026-10-07',
      notes: [ReleaseNote(type: CommitType.fix, subject: 'typo')],
    );
    expect(
      renderRelease(release),
      '## v0.1.1 - 2026-10-07\n\n### Fixed\n\n- typo\n',
    );
  });

  test('the changelog starts with the header and keeps release order', () {
    const older = Release(version: '0.1.0', date: '2026-10-01', notes: []);
    final text = renderChangelog([_release, older]);
    expect(text, startsWith('# Changelog\n'));
    expect(text.indexOf('v0.2.0'), lessThan(text.indexOf('v0.1.0')));
  });

  test('JSON round-trips, leaving out empty scope and breaking', () {
    final json = _release.toJson();
    final notes = json['notes']! as List<dynamic>;
    expect(notes[0], {'type': 'chore', 'subject': 'bump deps'});
    expect(notes[4], containsPair('breaking', true));
    expect(Release.fromJson(json).toJson(), json);
  });
}
