/// Suffixes of files produced by code generators; never hand-edited, so they
/// are exempt from size, coverage and design scans.
const generatedSuffixes = [
  '.g.dart',
  '.freezed.dart',
  '.drift.dart',
  '.gr.dart',
];

/// `drift_dev schema generate` writes one big file per schema version here.
const generatedDirectories = ['test/generated_migrations/'];

bool isGeneratedFile(String path) {
  final normalized = path.replaceAll(r'\', '/');
  return generatedSuffixes.any(normalized.endsWith) ||
      generatedDirectories.any(normalized.contains);
}
