import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/cancel_debt_command.dart';

part 'cancel_debt_command_provider.g.dart';

@riverpod
CancelDebtCommand cancelDebtCommand(Ref ref) => CancelDebtCommand(
  ref.watch(ordersRepositoryProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);
