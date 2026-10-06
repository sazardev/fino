import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/team_store_provider.dart';
import '../../../domain/commands/leave_team_command.dart';

part 'leave_team_command_provider.g.dart';

@riverpod
LeaveTeamCommand leaveTeamCommand(Ref ref) => LeaveTeamCommand(
  ref.watch(teamStoreProvider),
  ref.watch(liveDebtsDirectoryProvider),
);
