import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../session/session_user_id_provider.dart';
import 'directory_team.dart';
import 'people_directory_provider.dart';

part 'my_teams_provider.g.dart';

/// Los equipos de quien está en sesión (vacío sin sesión).
@riverpod
Stream<List<DirectoryTeam>> myTeams(Ref ref) {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId == null) return Stream.value(const []);
  return ref.watch(peopleDirectoryProvider).watchTeams(userId);
}
