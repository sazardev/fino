import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/change_order_total_command.dart';

part 'change_order_total_command_provider.g.dart';

@riverpod
ChangeOrderTotalCommand changeOrderTotalCommand(Ref ref) =>
    ChangeOrderTotalCommand(
      ref.watch(ordersRepositoryProvider),
      ref.watch(idGeneratorProvider),
      ref.watch(clockProvider),
    );
