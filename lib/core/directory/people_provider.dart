import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'directory_person.dart';
import 'people_directory_provider.dart';

part 'people_provider.g.dart';

/// Todas las personas de mis equipos, por clave `equipo/usuario`.
@riverpod
Stream<Map<String, DirectoryPerson>> people(Ref ref) => ref
    .watch(peopleDirectoryProvider)
    .watchPeople()
    .map((list) => {for (final person in list) person.key: person});
