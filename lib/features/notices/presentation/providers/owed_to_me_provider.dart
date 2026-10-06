import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/money/money.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../data/notices_repository_provider.dart';

part 'owed_to_me_provider.g.dart';

/// Quién me debe algo vivo en el equipo y cuánto (SPEC A1, A4).
@riverpod
Future<Map<String, Money>> owedToMe(Ref ref, String teamId) => ref
    .watch(noticeAudienceProvider)
    .owedTo(ref.watch(sessionUserIdProvider) ?? '', teamId);
