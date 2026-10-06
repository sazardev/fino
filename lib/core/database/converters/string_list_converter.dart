import 'dart:convert';

import 'package:drift/drift.dart';

/// Guarda una lista de textos (ids) como JSON en una sola columna.
class StringListConverter extends TypeConverter<List<String>, String> {
  const new();

  @override
  List<String> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List<dynamic>).cast<String>();

  @override
  String toSql(List<String> value) => jsonEncode(value);
}
