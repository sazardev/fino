import 'dart:io';

/// A git command that exited non-zero.
class GitException implements Exception {
  const new(this.command, this.message);

  final String command;
  final String message;

  @override
  String toString() => 'git $command failed:\n$message';
}

/// Runs `git [args]` and returns its trimmed stdout.
String git(List<String> args) {
  final result = Process.runSync('git', args);
  if (result.exitCode != 0) {
    // Hook failures print on either stream; keep both.
    throw GitException(
      args.join(' '),
      '${result.stderr}\n${result.stdout}'.trim(),
    );
  }
  return (result.stdout as String).trim();
}

/// The latest `v*` tag reachable from `HEAD`; null before the first release.
String? lastReleaseTag() {
  try {
    return git(['describe', '--tags', '--match', 'v*', '--abbrev=0']);
  } on GitException {
    return null;
  }
}

bool tagExists(String tag) =>
    Process.runSync('git', [
      'rev-parse',
      '-q',
      '--verify',
      'refs/tags/$tag',
    ]).exitCode ==
    0;

/// Commit subjects after [tag] (or the whole history), newest first.
List<String> commitSubjectsSince(String? tag) {
  final output = git(['log', if (tag != null) '$tag..HEAD', '--pretty=%s']);
  return output.isEmpty ? [] : output.split('\n');
}

bool hasUncommittedChanges() => git(['status', '--porcelain']).isNotEmpty;
