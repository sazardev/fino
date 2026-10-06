import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/auth_user.dart';
import 'auth_repository_provider.dart';

part 'auth_state_provider.g.dart';

/// The signed-in user: `loading` until Firebase answers, then `null` or a user.
@Riverpod(keepAlive: true)
Stream<AuthUser?> authState(Ref ref) =>
    ref.watch(authRepositoryProvider).watchUser();
