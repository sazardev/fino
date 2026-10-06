import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/asset_changelog_repository.dart';
import '../../domain/changelog_repository.dart';

part 'changelog_repository_provider.g.dart';

/// Where the release history comes from; tests override it.
@riverpod
ChangelogRepository changelogRepository(Ref ref) =>
    AssetChangelogRepository(rootBundle);
