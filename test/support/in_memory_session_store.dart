import 'package:fino/features/auth/data/session_store.dart';
import 'package:fino/features/auth/domain/auth_user.dart';

class InMemorySessionStore implements SessionStore {
  new([this.user]);

  AuthUser? user;

  @override
  Future<AuthUser?> read() async => user;

  @override
  Future<void> write(AuthUser? user) async => this.user = user;
}
