import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../data/inbox_repository_provider.dart';

part 'unread_count_provider.g.dart';

/// Cuántas notificaciones sin leer tengo (el número sobre "Buzón").
@riverpod
Stream<int> unreadCount(Ref ref) {
  final userId = ref.watch(sessionUserIdProvider);
  if (userId == null) return Stream.value(0);
  return ref.watch(inboxRepositoryProvider).watchUnreadCount(userId);
}
