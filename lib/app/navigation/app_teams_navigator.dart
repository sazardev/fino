import '../../features/teams/presentation/navigation/teams_navigator.dart';
import '../router/app_routes.dart';
import 'router_opener.dart';

/// [TeamsNavigator] con las rutas de la app.
class AppTeamsNavigator implements TeamsNavigator {
  const new(this._open);

  final RouterOpener _open;

  @override
  void openTeam(String teamId) =>
      _open.open(TeamDetailRoute(teamId: teamId).location);

  @override
  void showTeam(String teamId) =>
      _open.go(TeamDetailRoute(teamId: teamId).location);

  @override
  void openCreateTeam() => _open.push(const CreateTeamRoute().location);

  @override
  void openJoinTeam() => _open.push(const JoinTeamRoute().location);

  @override
  void openPayoutSetup(String teamId) =>
      _open.push(PayoutSetupRoute(teamId: teamId).location);

  @override
  void openNotice(String teamId, List<String> recipientIds) => _open.push(
    NoticeRoute(teamId: teamId, para: recipientIds.join(',')).location,
  );

  @override
  void showSettings() => _open.go(const SettingsRoute().location);
}
