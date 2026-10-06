import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/team_store_provider.dart';
import '../../../domain/commands/regenerate_invite_code_command.dart';
import 'invite_code_generator_provider.dart';

part 'regenerate_invite_code_command_provider.g.dart';

@riverpod
RegenerateInviteCodeCommand regenerateInviteCodeCommand(Ref ref) =>
    RegenerateInviteCodeCommand(
      ref.watch(teamStoreProvider),
      ref.watch(inviteCodeGeneratorProvider),
    );
