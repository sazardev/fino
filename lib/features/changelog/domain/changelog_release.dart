import 'package:freezed_annotation/freezed_annotation.dart';

import 'changelog_note.dart';

part 'changelog_release.freezed.dart';

/// Everything that shipped in one version.
@freezed
abstract class ChangelogRelease with _$ChangelogRelease {
  const factory({
    required String version,
    required DateTime date,
    required List<ChangelogNote> notes,
  }) = _ChangelogRelease;
}
