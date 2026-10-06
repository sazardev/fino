// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_dao.dart';

// ignore_for_file: type=lint
mixin _$TeamsDaoMixin on DatabaseAccessor<AppDatabase> {
  $TeamsTable get teams => attachedDatabase.teams;
  $TeamMembersTable get teamMembers => attachedDatabase.teamMembers;
  $PayoutMethodsTable get payoutMethods => attachedDatabase.payoutMethods;
  TeamsDaoManager get managers => TeamsDaoManager(this);
}

class TeamsDaoManager {
  final _$TeamsDaoMixin _db;
  TeamsDaoManager(this._db);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db.attachedDatabase, _db.teams);
  $$TeamMembersTableTableManager get teamMembers =>
      $$TeamMembersTableTableManager(_db.attachedDatabase, _db.teamMembers);
  $$PayoutMethodsTableTableManager get payoutMethods =>
      $$PayoutMethodsTableTableManager(_db.attachedDatabase, _db.payoutMethods);
}
