import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/add_debtors_command.dart';

part 'add_debtors_command_provider.g.dart';

@riverpod
AddDebtorsCommand addDebtorsCommand(Ref ref) => AddDebtorsCommand(
  ref.watch(ordersRepositoryProvider),
  ref.watch(teamDirectoryProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);
