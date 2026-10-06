// Fails when a Dart file is over 500 lines without a written justification.
// Usage: dart run tool/check_file_length.dart
import 'dart:io';

import 'src/file_length_checker.dart';

const _roots = ['lib', 'test', 'tool'];

Iterable<SourceFile> _sources() sync* {
  for (final root in _roots) {
    final dir = Directory(root);
    if (!dir.existsSync()) continue;
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        yield (path: entity.path, lines: entity.readAsLinesSync());
      }
    }
  }
}

void main() {
  final report = checkFileLengths(_sources());

  if (report.warnings.isNotEmpty) {
    stdout
      ..writeln('Over $softLineLimit lines (consider splitting):')
      ..writeln(report.warnings.map((w) => '  $w').join('\n'));
  }
  if (!report.passed) {
    stderr
      ..writeln('Over $hardLineLimit lines without justification:')
      ..writeln(report.offenders.map((o) => '  $o').join('\n'))
      ..writeln(
        'Split the file, or justify it with '
        '`// $justificationMarker <reason>` in its first $markerWindow lines.',
      );
    exit(1);
  }
  stdout.writeln('File length: OK');
}
