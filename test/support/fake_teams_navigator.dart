import 'package:fino/features/teams/presentation/navigation/teams_navigator.dart';

/// Anota a dónde quiso ir la pantalla, sin router.
class FakeTeamsNavigator implements TeamsNavigator {
  final calls = <String>[];

  @override
  void openTeam(String teamId) => calls.add('team:$teamId');

  @override
  void showTeam(String teamId) => calls.add('show:$teamId');

  @override
  void openCreateTeam() => calls.add('create');

  @override
  void openJoinTeam() => calls.add('join');

  @override
  void openPayoutSetup(String teamId) => calls.add('payout:$teamId');

  @override
  void openNotice(String teamId, List<String> recipientIds) =>
      calls.add('notice:$teamId:${recipientIds.join(',')}');

  @override
  void showSettings() => calls.add('settings');
}
