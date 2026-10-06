import 'package:freezed_annotation/freezed_annotation.dart';

import 'changelog_note_type.dart';

part 'changelog_note.freezed.dart';

/// One bullet of a release: a single user-facing change.
@freezed
abstract class ChangelogNote with _$ChangelogNote {
  const factory({
    required ChangelogNoteType type,
    required String subject,
    String? scope,
  }) = _ChangelogNote;
}
