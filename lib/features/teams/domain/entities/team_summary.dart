import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/team_role.dart';
import 'team.dart';

part 'team_summary.freezed.dart';

/// A team as its member sees it in a list: the role they have there and how
/// many people it has.
@freezed
abstract class TeamSummary with _$TeamSummary {
  const factory({
    required Team team,
    required TeamRole role,
    required int memberCount,
  }) = _TeamSummary;
}
