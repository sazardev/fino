import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/update_debt_amount_command.dart';

part 'update_debt_amount_command_provider.g.dart';

@riverpod
UpdateDebtAmountCommand updateDebtAmountCommand(Ref ref) =>
    UpdateDebtAmountCommand(
      ref.watch(ordersRepositoryProvider),
      ref.watch(idGeneratorProvider),
      ref.watch(clockProvider),
    );
