import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/daos/teams_dao_provider.dart';
import '../../data/local_teams_repository.dart';
import '../../domain/teams_repository.dart';

part 'teams_repository_provider.g.dart';

@Riverpod(keepAlive: true)
TeamsRepository teamsRepository(Ref ref) =>
    LocalTeamsRepository(ref.watch(teamsDaoProvider));
