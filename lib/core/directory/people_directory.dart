import 'directory_payout.dart';
import 'directory_person.dart';
import 'directory_team.dart';

/// Quién es quién en mis equipos: lo que toda pantalla necesita para mostrar
/// nombres y fotos sin conocer el feature de equipos.
abstract interface class PeopleDirectory {
  /// Los equipos de [userId], por nombre.
  Stream<List<DirectoryTeam>> watchTeams(String userId);

  /// Todas las personas de todos los equipos guardados.
  Stream<List<DirectoryPerson>> watchPeople();

  /// El método de cobro de [userId] en [teamId] si este dispositivo puede
  /// verlo (el dueño, o quien le debe algo vivo); `null` si no.
  Stream<DirectoryPayout?> watchPayout(String teamId, String userId);
}
