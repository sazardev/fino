import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/report_payment_command.dart';

part 'report_payment_command_provider.g.dart';

@riverpod
ReportPaymentCommand reportPaymentCommand(Ref ref) => ReportPaymentCommand(
  ref.watch(ordersRepositoryProvider),
  ref.watch(teamDirectoryProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);
