import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/review_debts_command.dart';

part 'review_debts_command_provider.g.dart';

@riverpod
ReviewDebtsCommand reviewDebtsCommand(Ref ref) => ReviewDebtsCommand(
  ref.watch(ordersRepositoryProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);
