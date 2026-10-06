import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/team_store_provider.dart';
import '../../domain/entities/team.dart';

part 'team_provider.g.dart';

@riverpod
Stream<Team?> team(Ref ref, String teamId) =>
    ref.watch(teamStoreProvider).watchTeam(teamId);
