import '../../features/auth/domain/auth_user.dart';
import '../../features/teams/domain/enums/team_role.dart';
import 'demo_member.dart';
import 'demo_team.dart';

/// The sample teams of the demo session: one the person runs and one they
/// are only a member of, so lists show both roles.
abstract final class DemoTeams {
  const new _();

  static const _ana = 'demo-ana';
  static const _beto = 'demo-beto';
  static const _carla = 'demo-carla';
  static const _diego = 'demo-diego';

  static List<DemoTeam> of(AuthUser me) {
    DemoMember member(String id, String name, [TeamRole? role]) =>
        (userId: id, name: name, role: role ?? TeamRole.member);

    final myself = member(
      me.uid,
      me.displayName ?? me.email ?? 'Yo',
      TeamRole.admin,
    );

    return [
      (
        id: 'demo-team-oficina',
        name: 'Oficina',
        inviteCode: 'OFICINA7',
        createdAt: DateTime.utc(2026, 1, 12),
        members: [
          myself,
          member(_ana, 'Ana López'),
          member(_beto, 'Beto Ruiz'),
          member(_carla, 'Carla Méndez'),
          member(_diego, 'Diego Torres'),
        ],
      ),
      (
        id: 'demo-team-comidas',
        name: 'Comidas del viernes',
        inviteCode: 'VIERNES4',
        createdAt: DateTime.utc(2026, 3, 6),
        members: [
          member(_ana, 'Ana López', TeamRole.admin),
          (userId: me.uid, name: myself.name, role: TeamRole.member),
          member(_beto, 'Beto Ruiz'),
          member(_carla, 'Carla Méndez'),
        ],
      ),
    ];
  }
}
