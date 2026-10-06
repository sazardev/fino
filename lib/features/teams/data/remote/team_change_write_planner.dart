import '../../../../core/sync/remote_write.dart';
import '../../domain/entities/team_change.dart';
import '../../domain/enums/team_change_kind.dart';
import 'team_lifecycle_write_planner.dart';
import 'team_membership_write_planner.dart';

/// Elige el planner que corresponde al tipo de acción y devuelve las
/// escrituras de UN lote de Firestore.
class TeamChangeWritePlanner {
  const new([
    this._lifecycle = const TeamLifecycleWritePlanner(),
    this._membership = const TeamMembershipWritePlanner(),
  ]);

  final TeamLifecycleWritePlanner _lifecycle;
  final TeamMembershipWritePlanner _membership;

  List<RemoteWrite> plan(TeamChange change) => switch (change.kind) {
    TeamChangeKind.none => const [],
    TeamChangeKind.created => _lifecycle.planCreate(change),
    TeamChangeKind.inviteRegenerated => _lifecycle.planRegenerateCode(
      change,
      previousCode: change.previousInviteCode!,
    ),
    TeamChangeKind.deleted => _lifecycle.planDelete(change),
    TeamChangeKind.joined => _membership.planJoin(
      change,
      inviteCode: change.inviteCode!,
    ),
    TeamChangeKind.membersRemoved => _membership.planRemoveMembers(
      change,
      teamId: change.teamId,
    ),
    TeamChangeKind.adminTransferred => _membership.planTransferAdmin(change),
    TeamChangeKind.payoutMethodSet => _membership.planPayoutMethod(change),
    TeamChangeKind.profileUpdated => _membership.planProfile(
      change.members.single,
    ),
  };
}
