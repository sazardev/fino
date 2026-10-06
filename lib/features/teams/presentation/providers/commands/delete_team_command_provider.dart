import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/team_store_provider.dart';
import '../../../domain/commands/delete_team_command.dart';

part 'delete_team_command_provider.g.dart';

@riverpod
DeleteTeamCommand deleteTeamCommand(Ref ref) => DeleteTeamCommand(
  ref.watch(teamStoreProvider),
  ref.watch(liveDebtsDirectoryProvider),
);
