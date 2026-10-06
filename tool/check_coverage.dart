// Fails when coverage/lcov.info is under the STACK.md §11 thresholds.
// Usage: flutter test --coverage && dart run tool/check_coverage.dart
import 'dart:io';

import 'src/coverage_rules.dart';
import 'src/lcov_parser.dart';

void main() {
  final lcov = File('coverage/lcov.info');
  if (!lcov.existsSync()) {
    stderr.writeln(
      'coverage/lcov.info not found: run `flutter test --coverage`.',
    );
    exit(1);
  }
  final failures = evaluateCoverage(parseLcov(lcov.readAsStringSync()));
  if (failures.isNotEmpty) {
    stderr
      ..writeln('Coverage below minimum:')
      ..writeln(failures.map((f) => '  $f').join('\n'));
    exit(1);
  }
  stdout.writeln('Coverage: OK');
}
