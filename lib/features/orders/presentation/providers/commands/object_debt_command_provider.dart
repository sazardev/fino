import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/object_debt_command.dart';

part 'object_debt_command_provider.g.dart';

@riverpod
ObjectDebtCommand objectDebtCommand(Ref ref) => ObjectDebtCommand(
  ref.watch(ordersRepositoryProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);
