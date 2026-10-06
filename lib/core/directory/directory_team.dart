import 'package:freezed_annotation/freezed_annotation.dart';

/// Uno de mis equipos, con lo mínimo para mostrarlo y elegirlo.
@immutable
final class DirectoryTeam {
  const new({required this.id, required this.name, required this.adminId});

  final String id;
  final String name;
  final String adminId;

  @override
  bool operator ==(Object other) =>
      other is DirectoryTeam &&
      other.id == id &&
      other.name == name &&
      other.adminId == adminId;

  @override
  int get hashCode => Object.hash(id, name, adminId);
}
