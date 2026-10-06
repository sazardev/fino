import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../data/inbox_repository_provider.dart';
import '../../domain/entities/inbox_notification.dart';

part 'inbox_notifications_provider.g.dart';

/// Mi buzón, lo más reciente primero (SPEC N2).
@riverpod
Stream<List<InboxNotification>> inboxNotifications(Ref ref) {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId == null) return Stream.value(const []);
  return ref.watch(inboxRepositoryProvider).watch(userId);
}
