import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database_provider.dart';
import '../../../core/ids/id_generator_provider.dart';
import '../../../core/time/clock_provider.dart';
import '../domain/orders_repository.dart';
import '../domain/team_directory.dart';
import 'local_orders_repository.dart';
import 'local_team_directory.dart';

part 'orders_repository_provider.g.dart';

@Riverpod(keepAlive: true)
OrdersRepository ordersRepository(Ref ref) => LocalOrdersRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);

@Riverpod(keepAlive: true)
TeamDirectory teamDirectory(Ref ref) =>
    LocalTeamDirectory(ref.watch(appDatabaseProvider));
