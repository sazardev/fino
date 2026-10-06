import 'package:fino/features/changelog/domain/changelog_release.dart';
import 'package:fino/features/changelog/domain/changelog_repository.dart';

/// Serves a fixed release history, or fails when [error] is set.
class FakeChangelogRepository implements ChangelogRepository {
  new([this.releases = const [], this.error]);

  final List<ChangelogRelease> releases;
  final Exception? error;

  @override
  Future<List<ChangelogRelease>> loadReleases() async {
    if (error != null) throw error!;
    return releases;
  }
}
