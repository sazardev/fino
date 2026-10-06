// Cuts a release from the Conventional Commits since the last `v*` tag: bumps
// the version in pubspec.yaml, regenerates CHANGELOG.md and the in-app
// assets/changelog.json, then commits `chore(release): vX.Y.Z` and tags it.
// The commit runs the normal pre-commit hooks; if they fail, nothing is left
// behind. Usage:
//   dart run tool/bump_version.dart <major|minor|patch> [--dry-run]
import 'dart:convert';
import 'dart:io';

import 'src/changelog_markdown.dart';
import 'src/conventional_commit.dart';
import 'src/git.dart';
import 'src/release.dart';
import 'src/version_bump.dart';

const _pubspecPath = 'pubspec.yaml';
const _jsonPath = 'assets/changelog.json';
const _markdownPath = 'CHANGELOG.md';
const List<String> _releaseFiles = [_pubspecPath, _jsonPath, _markdownPath];

const _usage =
    'Usage: dart run tool/bump_version.dart <major|minor|patch> [--dry-run]';

Never _fail(String message, [int code = 1]) {
  stderr.writeln(message);
  exit(code);
}

void main(List<String> args) {
  final dryRun = args.contains('--dry-run');
  final names = args.where((arg) => arg != '--dry-run').toList();
  final part = names.length == 1
      ? BumpPart.values.asNameMap()[names.single]
      : null;
  if (part == null) _fail(_usage, 64);

  try {
    _release(part, dryRun: dryRun);
  } on GitException catch (e) {
    _fail('$e');
  } on FormatException catch (e) {
    _fail(e.message);
  }
}

void _release(BumpPart part, {required bool dryRun}) {
  final bump = bumpPubspecVersion(File(_pubspecPath).readAsStringSync(), part);
  final tag = 'v${bump.to.split('+').first}';
  if (tagExists(tag)) _fail('Tag $tag already exists.');

  final since = lastReleaseTag();
  final subjects = commitSubjectsSince(since);
  if (subjects.isEmpty) _fail('No commits since $since: nothing to release.');

  final commits = subjects.map(ConventionalCommit.tryParse).nonNulls.toList();
  final release = Release(
    version: tag.substring(1),
    date: _today(),
    notes: commits.map(ReleaseNote.fromCommit).toList(),
  );

  stdout
    ..writeln('${since ?? 'First release'} → $tag (${bump.from} → ${bump.to})')
    ..writeln()
    ..writeln(renderRelease(release));
  final skipped = subjects.length - commits.length;
  if (skipped > 0) {
    stdout.writeln('$skipped commit(s) skipped: not Conventional Commits.\n');
  }

  if (dryRun) {
    stdout.writeln('Dry run: nothing written.');
    return;
  }
  if (hasUncommittedChanges()) {
    _fail(
      'Commit or stash your changes first: the release commit must carry '
      'only the version and the changelog.',
    );
  }

  final originals = {for (final path in _releaseFiles) path: _read(path)};
  try {
    final releases = [release, ..._existingReleases()];
    File(_pubspecPath).writeAsStringSync(bump.pubspec);
    File(_jsonPath).writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(releases)}\n',
    );
    File(_markdownPath).writeAsStringSync(renderChangelog(releases));
    git(['add', ..._releaseFiles]);
    git(['commit', '-m', 'chore(release): $tag']);
  } on GitException {
    _restore(originals);
    rethrow;
  }
  git(['tag', '-a', tag, '-m', tag]);
  stdout.writeln('Committed and tagged $tag.');
}

List<Release> _existingReleases() {
  final raw = _read(_jsonPath);
  if (raw == null) return [];
  return [
    for (final json in jsonDecode(raw) as List<dynamic>)
      Release.fromJson(json as Map<String, dynamic>),
  ];
}

String? _read(String path) {
  final file = File(path);
  return file.existsSync() ? file.readAsStringSync() : null;
}

/// Puts the release files back as they were and unstages them.
void _restore(Map<String, String?> originals) {
  for (final MapEntry(key: path, value: content) in originals.entries) {
    final file = File(path);
    if (content != null) {
      file.writeAsStringSync(content);
    } else if (file.existsSync()) {
      file.deleteSync();
    }
  }
  git(['reset', '-q', '--', ..._releaseFiles]);
}

String _today() => DateTime.now().toIso8601String().split('T').first;
