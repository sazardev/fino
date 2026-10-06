import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/team_store_provider.dart';
import '../../../domain/commands/transfer_admin_command.dart';

part 'transfer_admin_command_provider.g.dart';

@riverpod
TransferAdminCommand transferAdminCommand(Ref ref) =>
    TransferAdminCommand(ref.watch(teamStoreProvider));
