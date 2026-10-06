import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../app_database_provider.dart';
import 'outbox_dao.dart';

part 'outbox_dao_provider.g.dart';

@Riverpod(keepAlive: true)
OutboxDao outboxDao(Ref ref) => ref.watch(appDatabaseProvider).outboxDao;
