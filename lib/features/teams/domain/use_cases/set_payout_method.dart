import '../entities/payout_method.dart';
import '../entities/team_change.dart';
import '../entities/team_roster.dart';
import '../enums/team_change_kind.dart';
import '../failures/team_failure.dart';
import '../failures/team_failure_reason.dart';

/// Un miembro configura (o reemplaza) su método de cobro en el equipo.
///
/// Es por equipo (SPEC M1). No se puede quitar: solo reemplazar, para que
/// nunca queden deudas vivas sin a dónde pagar.
class SetPayoutMethod {
  const new();

  TeamChange call({
    required String userId,
    required TeamRoster roster,
    required PayoutMethod method,
  }) {
    final member = roster.memberOf(userId);
    if (member == null) {
      throw const TeamFailure(TeamFailureReason.notMember);
    }
    return TeamChange(
      kind: TeamChangeKind.payoutMethodSet,
      teamId: member.teamId,
      members: [member.copyWith(payoutMethod: method)],
    );
  }
}
