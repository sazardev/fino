import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/team_summary.dart';
import 'teams_repository_provider.dart';

part 'user_teams_provider.g.dart';

/// The teams [userId] belongs to, by name.
@riverpod
Stream<List<TeamSummary>> userTeams(Ref ref, String userId) =>
    ref.watch(teamsRepositoryProvider).watchTeamsOf(userId);
