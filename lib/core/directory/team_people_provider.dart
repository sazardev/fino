import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'directory_person.dart';
import 'people_provider.dart';

part 'team_people_provider.g.dart';

/// Los miembros de un equipo, por nombre.
@riverpod
Future<List<DirectoryPerson>> teamPeople(Ref ref, String teamId) async {
  final people = await ref.watch(peopleProvider.future);
  return [
    for (final person in people.values)
      if (person.teamId == teamId) person,
  ]..sort(
    (a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()),
  );
}
