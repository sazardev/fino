import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/coverage_rules.dart';
import '../../tool/src/lcov_parser.dart';

void main() {
  test('parseLcov reads files and skips generated ones', () {
    const lcov = '''
SF:lib/a.dart
LF:10
LH:8
end_of_record
SF:lib/a.g.dart
LF:100
LH:0
end_of_record
''';
    expect(parseLcov(lcov), [(path: 'lib/a.dart', found: 10, hit: 8)]);
  });

  test('global threshold fails under 75%', () {
    final failures = evaluateCoverage([
      (path: 'lib/a.dart', found: 100, hit: 74),
    ]);
    expect(failures, hasLength(1));
    expect(failures.single, startsWith('global'));
  });

  test('group rules apply only when matching files exist', () {
    final ok = evaluateCoverage([(path: 'lib/a.dart', found: 100, hit: 80)]);
    expect(ok, isEmpty);

    final failures = evaluateCoverage([
      (path: 'lib/a.dart', found: 100, hit: 100),
      (path: 'lib/f/domain/x.dart', found: 100, hit: 80),
    ]);
    expect(failures.single, startsWith('domain'));
  });
}
