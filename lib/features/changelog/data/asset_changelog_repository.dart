import 'dart:convert';

import 'package:flutter/services.dart';

import '../domain/changelog_release.dart';
import '../domain/changelog_repository.dart';
import 'changelog_release_mapper.dart';

/// Reads the `assets/changelog.json` bundled by `tool/bump_version.dart`.
class AssetChangelogRepository implements ChangelogRepository {
  const new(this._bundle);

  static const assetPath = 'assets/changelog.json';

  final AssetBundle _bundle;

  @override
  Future<List<ChangelogRelease>> loadReleases() async {
    final raw = await _bundle.loadString(assetPath);
    return [
      for (final json in jsonDecode(raw) as List<dynamic>)
        releaseFromJson(json as Map<String, dynamic>),
    ];
  }
}
