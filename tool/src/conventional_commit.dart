/// Every type of the Conventional Commits spec, so nothing is dropped as
/// "unparseable" just because the app doesn't surface it.
enum CommitType {
  feat,
  fix,
  perf,
  refactor,
  docs,
  test,
  build,
  ci,
  chore,
  style,
  revert,
}

/// One Conventional Commit header (`type(scope)!: subject`) split in parts.
class ConventionalCommit {
  const new({
    required this.type,
    required this.subject,
    this.scope,
    this.breaking = false,
  });

  final CommitType type;
  final String? scope;
  final bool breaking;
  final String subject;

  static final _header = RegExp(r'^(\w+)(?:\(([^)]+)\))?(!)?:\s*(.+)$');
  static final Map<String, CommitType> _typesByName = CommitType.values
      .asNameMap();

  /// Null for anything that isn't a well-formed header (merge commits, free
  /// text, unknown types): the changelog only lists what it can classify.
  static ConventionalCommit? tryParse(String header) {
    final match = _header.firstMatch(header.trim());
    final type = _typesByName[match?.group(1)];
    if (match == null || type == null) return null;
    return ConventionalCommit(
      type: type,
      scope: match.group(2),
      breaking: match.group(3) != null,
      subject: match.group(4)!.trim(),
    );
  }
}
