import 'changelog_release.dart';

/// Read-only source of the release history. Releases are only ever written
/// by `tool/bump_version.dart`, never from inside the app.
abstract interface class ChangelogRepository {
  /// Newest release first.
  Future<List<ChangelogRelease>> loadReleases();
}
