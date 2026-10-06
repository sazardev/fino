import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/team_store_provider.dart';
import '../../../domain/commands/refresh_member_profile_command.dart';

part 'refresh_member_profile_command_provider.g.dart';

@riverpod
RefreshMemberProfileCommand refreshMemberProfileCommand(Ref ref) =>
    RefreshMemberProfileCommand(ref.watch(teamStoreProvider));
