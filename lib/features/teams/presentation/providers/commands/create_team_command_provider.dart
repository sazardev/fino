import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/team_store_provider.dart';
import '../../../domain/commands/create_team_command.dart';
import 'invite_code_generator_provider.dart';

part 'create_team_command_provider.g.dart';

@riverpod
CreateTeamCommand createTeamCommand(Ref ref) => CreateTeamCommand(
  ref.watch(teamStoreProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(inviteCodeGeneratorProvider),
  ref.watch(clockProvider),
);
