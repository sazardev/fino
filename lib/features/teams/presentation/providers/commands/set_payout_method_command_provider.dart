import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/team_store_provider.dart';
import '../../../domain/commands/set_payout_method_command.dart';

part 'set_payout_method_command_provider.g.dart';

@riverpod
SetPayoutMethodCommand setPayoutMethodCommand(Ref ref) =>
    SetPayoutMethodCommand(ref.watch(teamStoreProvider));
