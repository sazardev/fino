/// Suffixes of files produced by code generators; never hand-edited, so they
/// are exempt from size, coverage and design scans.
const generatedSuffixes = [
  '.g.dart',
  '.freezed.dart',
  '.drift.dart',
  '.gr.dart',
];

bool isGeneratedFile(String path) => generatedSuffixes.any(path.endsWith);
