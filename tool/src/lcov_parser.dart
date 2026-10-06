import 'generated_files.dart';

/// Line coverage of one source file.
typedef FileCoverage = ({String path, int found, int hit});

/// Parses `lcov.info` text into per-file coverage, skipping generated files.
List<FileCoverage> parseLcov(String content) {
  final result = <FileCoverage>[];
  String? path;
  var found = 0;
  var hit = 0;
  for (final line in content.split('\n')) {
    if (line.startsWith('SF:')) {
      path = line.substring(3).trim();
      found = 0;
      hit = 0;
    } else if (line.startsWith('LF:')) {
      found = int.parse(line.substring(3));
    } else if (line.startsWith('LH:')) {
      hit = int.parse(line.substring(3));
    } else if (line.trim() == 'end_of_record' && path != null) {
      if (!isGeneratedFile(path)) {
        result.add((path: path, found: found, hit: hit));
      }
      path = null;
    }
  }
  return result;
}
