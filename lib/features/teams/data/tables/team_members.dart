import 'package:drift/drift.dart';

import '../../domain/enums/team_role.dart';

/// Miembros de cada equipo, con el perfil que vino de Google.
@DataClassName('TeamMemberRow')
@TableIndex(name: 'team_members_user', columns: {#userId})
class TeamMembers extends Table {
  TextColumn get teamId => text()();
  TextColumn get userId => text()();
  TextColumn get role => textEnum<TeamRole>()();
  DateTimeColumn get joinedAt => dateTime()();
  TextColumn get displayName => text()();
  TextColumn get photoUrl => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {teamId, userId};
}
