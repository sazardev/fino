import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/auth_user.dart';
import 'session_store.dart';

class SharedPreferencesSessionStore implements SessionStore {
  static const _key = 'session.user';

  @override
  Future<AuthUser?> read() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_key);
    if (raw == null) return null;
    final json = jsonDecode(raw) as Map<String, Object?>;
    return AuthUser(
      uid: json['uid']! as String,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  @override
  Future<void> write(AuthUser? user) async {
    final preferences = await SharedPreferences.getInstance();
    if (user == null) {
      await preferences.remove(_key);
      return;
    }
    await preferences.setString(
      _key,
      jsonEncode({
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        'photoUrl': user.photoUrl,
      }),
    );
  }
}
