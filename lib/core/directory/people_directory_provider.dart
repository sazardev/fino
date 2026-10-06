import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database_provider.dart';
import 'local_people_directory.dart';
import 'people_directory.dart';

part 'people_directory_provider.g.dart';

@Riverpod(keepAlive: true)
PeopleDirectory peopleDirectory(Ref ref) =>
    LocalPeopleDirectory(ref.watch(appDatabaseProvider));
