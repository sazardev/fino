import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database_provider.dart';
import '../../../core/ids/id_generator_provider.dart';
import '../../../core/time/clock_provider.dart';
import '../domain/inbox_repository.dart';
import 'local_inbox_repository.dart';

part 'inbox_repository_provider.g.dart';

@Riverpod(keepAlive: true)
InboxRepository inboxRepository(Ref ref) => LocalInboxRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);
