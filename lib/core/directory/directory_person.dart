import 'package:freezed_annotation/freezed_annotation.dart';

/// Alguien de uno de mis equipos, como se muestra: nombre y foto de Google.
@immutable
final class DirectoryPerson {
  const new({
    required this.teamId,
    required this.userId,
    required this.displayName,
    this.photoUrl,
    this.isAdmin = false,
  });

  final String teamId;
  final String userId;
  final String displayName;
  final String? photoUrl;
  final bool isAdmin;

  /// Clave única: la misma persona puede estar en varios equipos.
  String get key => keyOf(teamId, userId);

  static String keyOf(String teamId, String userId) => '$teamId/$userId';

  @override
  bool operator ==(Object other) =>
      other is DirectoryPerson &&
      other.teamId == teamId &&
      other.userId == userId &&
      other.displayName == displayName &&
      other.photoUrl == photoUrl &&
      other.isAdmin == isAdmin;

  @override
  int get hashCode => Object.hash(teamId, userId, displayName, photoUrl);
}
