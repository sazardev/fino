import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/teams/data/daos/teams_dao_provider.dart';
import 'demo_data_seeder.dart';

part 'demo_data_seeder_provider.g.dart';

@Riverpod(keepAlive: true)
DemoDataSeeder demoDataSeeder(Ref ref) =>
    DemoDataSeeder(ref.watch(teamsDaoProvider));
