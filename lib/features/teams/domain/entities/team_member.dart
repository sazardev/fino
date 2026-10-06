import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/team_role.dart';
import 'payout_method.dart';

part 'team_member.freezed.dart';

/// Un usuario dentro de un equipo: su perfil de Google (SPEC U2) y su
/// método de cobro de ese equipo.
@freezed
abstract class TeamMember with _$TeamMember {
  const factory({
    required String teamId,
    required String userId,
    required TeamRole role,
    required DateTime joinedAt,
    required String displayName,
    String? photoUrl,
    PayoutMethod? payoutMethod,
  }) = _TeamMember;
}
