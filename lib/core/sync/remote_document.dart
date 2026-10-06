import 'package:freezed_annotation/freezed_annotation.dart';

/// Un documento de Firestore ya decodificado, sin depender del SDK.
///
/// Los valores son `null`, `bool`, `int`, `double`, `String`, `DateTime`,
/// `List` o `Map<String, Object?>`.
@immutable
final class RemoteDocument {
  const new(this.path, this.fields);

  /// Ruta completa, p. ej. `teams/t1/debts/d1`.
  final String path;
  final Map<String, Object?> fields;

  String get id => path.substring(path.lastIndexOf('/') + 1);

  /// Ruta de la colección que lo contiene.
  String get collection => path.substring(0, path.lastIndexOf('/'));

  @override
  bool operator ==(Object other) =>
      other is RemoteDocument &&
      other.path == path &&
      _deepEquals(other.fields, fields);

  @override
  int get hashCode => path.hashCode;

  static bool _deepEquals(Object? a, Object? b) {
    if (a is Map<String, Object?> && b is Map<String, Object?>) {
      return a.length == b.length &&
          a.keys.every((k) => b.containsKey(k) && _deepEquals(a[k], b[k]));
    }
    if (a is List<Object?> && b is List<Object?>) {
      return a.length == b.length &&
          List.generate(
            a.length,
            (i) => _deepEquals(a[i], b[i]),
          ).every((same) => same);
    }
    return a == b;
  }

  @override
  String toString() => 'RemoteDocument($path)';
}
