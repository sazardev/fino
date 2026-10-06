import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/payout_method.dart';
import '../../domain/entities/team_member.dart';

/// Fila local ↔ [TeamMember].
abstract final class TeamMemberMapper {
  /// [payoutMethod] solo viene si este usuario puede verlo (SPEC M4).
  static TeamMember toDomain(TeamMemberRow row, {PayoutMethod? payoutMethod}) =>
      TeamMember(
        teamId: row.teamId,
        userId: row.userId,
        role: row.role,
        joinedAt: row.joinedAt.toUtc(),
        displayName: row.displayName,
        photoUrl: row.photoUrl,
        payoutMethod: payoutMethod,
      );

  static TeamMembersCompanion toCompanion(TeamMember member) =>
      TeamMembersCompanion.insert(
        teamId: member.teamId,
        userId: member.userId,
        role: member.role,
        joinedAt: member.joinedAt,
        displayName: member.displayName,
        photoUrl: Value(member.photoUrl),
      );
}
