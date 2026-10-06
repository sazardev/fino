import 'generated_files.dart';

/// Hard limit: a file above this fails unless it carries a justification.
const hardLineLimit = 500;

/// Healthy target: files above this are listed as warnings only.
const softLineLimit = 200;

/// Marker that justifies a file above [hardLineLimit]. It must carry a reason
/// and sit within the first [markerWindow] lines.
const justificationMarker = 'file-length-ok:';
const markerWindow = 5;

/// A source file already read: its path and lines.
typedef SourceFile = ({String path, List<String> lines});

/// Result of scanning a set of files.
class FileLengthReport {
  const new({required this.offenders, required this.warnings});

  /// Over the hard limit without a justification: fail the build.
  final List<String> offenders;

  /// Over the soft limit: informational.
  final List<String> warnings;

  bool get passed => offenders.isEmpty;
}

/// Whether [lines] open with a `// file-length-ok: <reason>` marker.
bool hasJustification(List<String> lines) {
  for (final line in lines.take(markerWindow)) {
    final index = line.indexOf(justificationMarker);
    if (!line.trimLeft().startsWith('//') || index < 0) continue;
    if (line.substring(index + justificationMarker.length).trim().isNotEmpty) {
      return true;
    }
  }
  return false;
}

FileLengthReport checkFileLengths(Iterable<SourceFile> files) {
  final offenders = <String>[];
  final warnings = <String>[];
  for (final file in files) {
    if (isGeneratedFile(file.path)) continue;
    final count = file.lines.length;
    if (count > hardLineLimit && !hasJustification(file.lines)) {
      offenders.add('${file.path} ($count lines)');
    } else if (count > softLineLimit) {
      warnings.add('${file.path} ($count lines)');
    }
  }
  return FileLengthReport(offenders: offenders, warnings: warnings);
}
