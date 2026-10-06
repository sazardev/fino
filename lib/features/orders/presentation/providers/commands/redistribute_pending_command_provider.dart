import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/redistribute_pending_command.dart';

part 'redistribute_pending_command_provider.g.dart';

@riverpod
RedistributePendingCommand redistributePendingCommand(Ref ref) =>
    RedistributePendingCommand(
      ref.watch(ordersRepositoryProvider),
      ref.watch(idGeneratorProvider),
      ref.watch(clockProvider),
    );
