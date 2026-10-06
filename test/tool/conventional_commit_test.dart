import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/conventional_commit.dart';

void main() {
  test('parses type, scope and subject', () {
    final commit = ConventionalCommit.tryParse('feat(auth): add Google login')!;
    expect(commit.type, CommitType.feat);
    expect(commit.scope, 'auth');
    expect(commit.subject, 'add Google login');
    expect(commit.breaking, isFalse);
  });

  test('scope is optional', () {
    final commit = ConventionalCommit.tryParse('fix: stop the crash')!;
    expect(commit.scope, isNull);
    expect(commit.type, CommitType.fix);
  });

  test('the bang marks a breaking change', () {
    final commit = ConventionalCommit.tryParse('feat(api)!: drop v1')!;
    expect(commit.breaking, isTrue);
    expect(commit.subject, 'drop v1');
  });

  test('subjects may contain colons', () {
    final commit = ConventionalCommit.tryParse('docs: note: read this')!;
    expect(commit.subject, 'note: read this');
  });

  test('anything else is not a Conventional Commit', () {
    expect(ConventionalCommit.tryParse('Merge branch main'), isNull);
    expect(ConventionalCommit.tryParse('wip: stuff'), isNull);
    expect(ConventionalCommit.tryParse('feat:'), isNull);
    expect(ConventionalCommit.tryParse(''), isNull);
  });
}
