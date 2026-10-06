import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/team_store_provider.dart';
import '../../../domain/commands/expel_member_command.dart';

part 'expel_member_command_provider.g.dart';

@riverpod
ExpelMemberCommand expelMemberCommand(Ref ref) => ExpelMemberCommand(
  ref.watch(teamStoreProvider),
  ref.watch(liveDebtsDirectoryProvider),
);
