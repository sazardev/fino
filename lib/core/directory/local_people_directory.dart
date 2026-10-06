import 'package:drift/drift.dart';

import '../database/app_database.dart';
import 'directory_payout.dart';
import 'directory_person.dart';
import 'directory_team.dart';
import 'people_directory.dart';

/// [PeopleDirectory] leído de Drift.
class LocalPeopleDirectory implements PeopleDirectory {
  const new(this._db);

  final AppDatabase _db;

  @override
  Stream<List<DirectoryTeam>> watchTeams(String userId) => _db.teamsDao
      .watchTeamsOf(userId)
      .map(
        (rows) => [
          for (final row in rows)
            DirectoryTeam(id: row.id, name: row.name, adminId: row.adminId),
        ],
      );

  @override
  Stream<List<DirectoryPerson>> watchPeople() {
    final query = _db.select(_db.teamMembers).join([
      leftOuterJoin(_db.teams, _db.teams.id.equalsExp(_db.teamMembers.teamId)),
    ]);
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          _person(
            row.readTable(_db.teamMembers),
            row.readTableOrNull(_db.teams),
          ),
      ],
    );
  }

  @override
  Stream<DirectoryPayout?> watchPayout(String teamId, String userId) => _db
      .teamsDao
      .watchPayoutMethod(teamId, userId)
      .map(
        (row) => row == null
            ? null
            : DirectoryPayout(
                isClabe: row.type.name == 'clabe',
                number: row.number,
                bankName: row.bankName,
                holderName: row.holderName,
              ),
      );

  DirectoryPerson _person(TeamMemberRow member, TeamRow? team) =>
      DirectoryPerson(
        teamId: member.teamId,
        userId: member.userId,
        displayName: member.displayName,
        photoUrl: member.photoUrl,
        isAdmin: team?.adminId == member.userId,
      );
}
