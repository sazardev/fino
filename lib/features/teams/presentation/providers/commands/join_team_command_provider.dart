import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/time/clock_provider.dart';
import '../../../data/team_store_provider.dart';
import '../../../domain/commands/join_team_command.dart';

part 'join_team_command_provider.g.dart';

@riverpod
JoinTeamCommand joinTeamCommand(Ref ref) => JoinTeamCommand(
  ref.watch(teamStoreProvider),
  ref.watch(inviteLookupProvider),
  ref.watch(clockProvider),
);
