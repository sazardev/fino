import 'lcov_parser.dart';

/// A minimum line-coverage percentage for the files whose path contains
/// [pathPattern] (`null` = every file). Group rules apply only when at least
/// one file matches.
class CoverageRule {
  const new(this.name, this.minimum, [this.pathPattern]);

  final String name;
  final double minimum;
  final String? pathPattern;
}

/// STACK.md §11.
const coverageRules = [
  CoverageRule('global', 75),
  CoverageRule('domain', 90, '/domain/'),
  CoverageRule('notifiers/providers', 90, '/presentation/providers/'),
  CoverageRule('repositories/DAOs', 80, '/data/'),
];

/// Returns one failure message per broken rule (empty = all good).
List<String> evaluateCoverage(
  List<FileCoverage> files, {
  List<CoverageRule> rules = coverageRules,
}) {
  final failures = <String>[];
  for (final rule in rules) {
    final pattern = rule.pathPattern;
    final scope = pattern == null
        ? files
        : files.where((f) => f.path.replaceAll(r'\', '/').contains(pattern));
    final found = scope.fold<int>(0, (sum, f) => sum + f.found);
    if (found == 0) continue;
    final hit = scope.fold<int>(0, (sum, f) => sum + f.hit);
    final percent = hit * 100 / found;
    if (percent < rule.minimum) {
      failures.add(
        '${rule.name}: ${percent.toStringAsFixed(1)}% '
        '< ${rule.minimum.toStringAsFixed(0)}%',
      );
    }
  }
  return failures;
}
