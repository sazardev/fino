import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/notices_repository_provider.dart';
import '../../../domain/commands/send_notice_command.dart';

part 'send_notice_command_provider.g.dart';

@riverpod
SendNoticeCommand sendNoticeCommand(Ref ref) => SendNoticeCommand(
  ref.watch(noticesRepositoryProvider),
  ref.watch(noticeAudienceProvider),
  ref.watch(idGeneratorProvider),
  ref.watch(clockProvider),
);
