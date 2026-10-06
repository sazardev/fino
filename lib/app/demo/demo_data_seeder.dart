import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';
import '../../features/auth/domain/auth_user.dart';
import '../../features/teams/data/daos/teams_dao.dart';
import '../../features/teams/data/payout_method_type.dart';
import '../../features/teams/domain/enums/team_role.dart';
import 'demo_teams.dart';

/// Fills the local database with sample data for [AuthUser]. Writes straight
/// to Drift, bypassing the outbox, so nothing is sent to the backend. Safe to
/// run again: every row has a fixed id and is overwritten.
class DemoDataSeeder {
  const new(this._teams);

  final TeamsDao _teams;

  /// A valid CLABE (check digit included), so it passes the app's own rules.
  static const _clabe = '012180001183597172';

  Future<void> seed(AuthUser me) =>
      _teams.attachedDatabase.transaction(() async {
        for (final team in DemoTeams.of(me)) {
          await _teams.upsertTeam(
            TeamsCompanion.insert(
              id: team.id,
              name: team.name,
              adminId: team.members
                  .firstWhere((m) => m.role == TeamRole.admin)
                  .userId,
              inviteCode: team.inviteCode,
              createdAt: team.createdAt,
            ),
          );
          for (final (i, m) in team.members.indexed) {
            await _teams.upsertMember(
              TeamMembersCompanion.insert(
                teamId: team.id,
                userId: m.userId,
                role: m.role,
                joinedAt: team.createdAt.add(Duration(days: i)),
                displayName: m.name,
                photoUrl: Value(m.userId == me.uid ? me.photoUrl : null),
              ),
            );
          }
        }
        await _teams.upsertPayoutMethod(
          PayoutMethodsCompanion.insert(
            teamId: 'demo-team-oficina',
            userId: me.uid,
            type: PayoutMethodType.clabe,
            number: _clabe,
            bankName: const Value('BBVA'),
            holderName: Value(me.displayName),
          ),
        );
      });
}
