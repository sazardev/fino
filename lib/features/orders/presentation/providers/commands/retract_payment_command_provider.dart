import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/retract_payment_command.dart';

part 'retract_payment_command_provider.g.dart';

@riverpod
RetractPaymentCommand retractPaymentCommand(Ref ref) => RetractPaymentCommand(
  ref.watch(ordersRepositoryProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);
