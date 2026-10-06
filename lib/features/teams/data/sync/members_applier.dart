import '../../../../core/sync/pull/scoped_collection_applier.dart';
import '../../../../core/sync/remote_document.dart';
import '../mappers/team_member_mapper.dart';
import '../remote/team_member_remote_mapper.dart';

/// `teams/{team}/members` → Drift.
class MembersApplier extends ScopedCollectionApplier {
  const new(super.db, this.teamId);

  final String teamId;

  @override
  Future<void> upsert(RemoteDocument document) => db.teamsDao.upsertMember(
    TeamMemberMapper.toCompanion(
      TeamMemberRemoteMapper.fromFields(teamId, document.fields),
    ),
  );

  @override
  Future<void> delete(String id) async {
    await db.teamsDao.removeMember(teamId, id);
    await db.teamsDao.removePayoutMethod(teamId, id);
  }

  @override
  Future<Set<String>> localIds() async => {
    for (final row in await db.teamsDao.membersOf(teamId)) row.userId,
  };

  @override
  String pathOf(String id) =>
      '${TeamMemberRemoteMapper.collection(teamId)}/$id';
}
