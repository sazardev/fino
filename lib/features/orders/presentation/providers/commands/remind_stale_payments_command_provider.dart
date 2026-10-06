import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/remind_stale_payments_command.dart';

part 'remind_stale_payments_command_provider.g.dart';

@riverpod
RemindStalePaymentsCommand remindStalePaymentsCommand(Ref ref) =>
    RemindStalePaymentsCommand(
      ref.watch(ordersRepositoryProvider),
      ref.watch(clockProvider),
    );
