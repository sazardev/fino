import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

/// The signed-in person, as the app sees them.
@freezed
abstract class AuthUser with _$AuthUser {
  const factory({
    required String uid,
    String? displayName,
    String? email,
    String? photoUrl,
  }) = _AuthUser;
}
