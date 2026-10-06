import 'entities/payout_method.dart';
import 'entities/team.dart';
import 'entities/team_change.dart';
import 'entities/team_member.dart';
import 'entities/team_roster.dart';

/// Equipos, miembros y métodos de cobro: lo que la UI observa y lo que los
/// comandos necesitan para decidir. Offline-first, como `OrdersRepository`.
abstract interface class TeamStore {
  Stream<List<TeamMember>> watchMembers(String teamId);

  /// El método de cobro de [userId] si este dispositivo puede verlo (M4).
  Stream<PayoutMethod?> watchPayoutMethod(String teamId, String userId);

  Stream<Team?> watchTeam(String teamId);

  Future<Team?> findTeam(String teamId);

  Future<TeamRoster> rosterOf(String teamId);

  /// Guarda el resultado de una acción: filas locales y lote para el
  /// servidor, en una sola transacción. [actorId] es quien la ejecutó.
  Future<void> apply(TeamChange change, {required String actorId});
}
