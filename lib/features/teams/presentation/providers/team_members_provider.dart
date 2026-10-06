import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/team_store_provider.dart';
import '../../domain/entities/team_member.dart';

part 'team_members_provider.g.dart';

/// Los miembros de un equipo, el más antiguo primero.
@riverpod
Stream<List<TeamMember>> teamMembers(Ref ref, String teamId) =>
    ref.watch(teamStoreProvider).watchMembers(teamId);
