import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database_provider.dart';
import '../../../core/ids/id_generator_provider.dart';
import '../../../core/time/clock_provider.dart';
import '../domain/notice_audience.dart';
import '../domain/notices_repository.dart';
import 'local_notice_audience.dart';
import 'local_notices_repository.dart';

part 'notices_repository_provider.g.dart';

@Riverpod(keepAlive: true)
NoticesRepository noticesRepository(Ref ref) => LocalNoticesRepository(
  ref.watch(appDatabaseProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);

@Riverpod(keepAlive: true)
NoticeAudience noticeAudience(Ref ref) =>
    LocalNoticeAudience(ref.watch(appDatabaseProvider));
