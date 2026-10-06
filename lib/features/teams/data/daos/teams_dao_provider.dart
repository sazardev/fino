import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database_provider.dart';
import 'teams_dao.dart';

part 'teams_dao_provider.g.dart';

@Riverpod(keepAlive: true)
TeamsDao teamsDao(Ref ref) => ref.watch(appDatabaseProvider).teamsDao;
