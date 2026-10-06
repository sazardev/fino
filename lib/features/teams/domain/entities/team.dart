import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';

/// Grupo cerrado al que se entra con un código de invitación (SPEC §4).
@freezed
abstract class Team with _$Team {
  const factory({
    required String id,
    required String name,
    required String inviteCode,
    required DateTime createdAt,
  }) = _Team;
}
