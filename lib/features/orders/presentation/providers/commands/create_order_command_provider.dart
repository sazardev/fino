import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/create_order_command.dart';

part 'create_order_command_provider.g.dart';

@riverpod
CreateOrderCommand createOrderCommand(Ref ref) => CreateOrderCommand(
  ref.watch(ordersRepositoryProvider),
  ref.watch(teamDirectoryProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);
