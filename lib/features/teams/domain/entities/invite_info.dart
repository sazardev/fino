import 'package:freezed_annotation/freezed_annotation.dart';

/// A qué equipo lleva un código de invitación (lo único que se puede saber
/// antes de entrar).
@immutable
final class InviteInfo {
  const new({required this.teamId, required this.teamName});

  final String teamId;
  final String teamName;

  @override
  bool operator ==(Object other) =>
      other is InviteInfo &&
      other.teamId == teamId &&
      other.teamName == teamName;

  @override
  int get hashCode => Object.hash(teamId, teamName);
}
