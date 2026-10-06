import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/file_length_checker.dart';

List<String> _lines(int n, {List<String> head = const []}) => [
  ...head,
  for (var i = head.length; i < n; i++) '// line $i',
];

void main() {
  SourceFile file(String path, List<String> lines) =>
      (path: path, lines: lines);

  test('a file within 500 lines passes', () {
    final report = checkFileLengths([file('lib/a.dart', _lines(500))]);
    expect(report.passed, isTrue);
  });

  test('a file over 500 lines fails', () {
    final report = checkFileLengths([file('lib/a.dart', _lines(501))]);
    expect(report.offenders, ['lib/a.dart (501 lines)']);
  });

  test('a justified file over 500 lines passes', () {
    final report = checkFileLengths([
      file(
        'lib/a.dart',
        _lines(600, head: ['// file-length-ok: static table']),
      ),
    ]);
    expect(report.passed, isTrue);
  });

  test('a marker without a reason does not count', () {
    final report = checkFileLengths([
      file('lib/a.dart', _lines(600, head: ['// file-length-ok:'])),
    ]);
    expect(report.passed, isFalse);
  });

  test('a marker past the first 5 lines does not count', () {
    final lines = _lines(600);
    lines[5] = '// file-length-ok: too late';
    expect(checkFileLengths([file('lib/a.dart', lines)]).passed, isFalse);
  });

  test('generated files are ignored', () {
    final report = checkFileLengths([
      file('lib/a.g.dart', _lines(900)),
      file('lib/a.freezed.dart', _lines(900)),
      file('lib/a.drift.dart', _lines(900)),
    ]);
    expect(report.passed, isTrue);
    expect(report.warnings, isEmpty);
  });

  test('files over 200 lines are warnings, not failures', () {
    final report = checkFileLengths([file('lib/a.dart', _lines(201))]);
    expect(report.passed, isTrue);
    expect(report.warnings, ['lib/a.dart (201 lines)']);
  });
}
