import 'package:freezed_annotation/freezed_annotation.dart';

/// Quién está en sesión, con lo que muestra Google (SPEC U2).
@immutable
final class SessionProfile {
  const new({required this.uid, required this.displayName, this.photoUrl});

  final String uid;
  final String displayName;
  final String? photoUrl;

  @override
  bool operator ==(Object other) =>
      other is SessionProfile &&
      other.uid == uid &&
      other.displayName == displayName &&
      other.photoUrl == photoUrl;

  @override
  int get hashCode => Object.hash(uid, displayName, photoUrl);
}
