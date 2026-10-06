import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_database.dart';
import 'open_database_connection.dart';

part 'app_database_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase(openDatabaseConnection());
  ref.onDispose(database.close);
  return database;
}
