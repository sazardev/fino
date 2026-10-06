import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/changelog_release.dart';
import 'changelog_repository_provider.dart';

part 'changelog_releases_provider.g.dart';

/// The release history, newest first.
@riverpod
Future<List<ChangelogRelease>> changelogReleases(Ref ref) =>
    ref.watch(changelogRepositoryProvider).loadReleases();
