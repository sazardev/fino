/// A dónde llevan las pantallas de equipos. Lo implementa la app.
abstract interface class TeamsNavigator {
  void openTeam(String teamId);

  /// Cierra el formulario actual y muestra el equipo (tras crear o entrar).
  void showTeam(String teamId);

  void openCreateTeam();

  void openJoinTeam();

  void openPayoutSetup(String teamId);

  /// Escribir un aviso a miembros del equipo (SPEC §8).
  void openNotice(String teamId, List<String> recipientIds);

  /// Tras salir o eliminar: de vuelta a Ajustes.
  void showSettings();
}
