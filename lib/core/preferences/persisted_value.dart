import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'codecs/value_codec.dart';

/// A setting that screens can listen to and that survives restarts.
///
/// Reads its stored value synchronously on creation, so the first frame
/// already shows the user's choice.
class PersistedValue<T> extends ValueNotifier<T> {
  PersistedValue({
    required SharedPreferences prefs,
    required this.key,
    required T initial,
    required this.codec,
  }) : _prefs = prefs,
       super(_read(prefs, key, codec) ?? initial);

  final String key;
  final ValueCodec<T> codec;
  final SharedPreferences _prefs;

  static T? _read<T>(SharedPreferences prefs, String key, ValueCodec<T> codec) {
    final raw = prefs.getString(key);
    return raw == null ? null : codec.decode(raw);
  }

  /// Applies [next] immediately and stores it.
  Future<void> update(T next) async {
    value = next;
    await _prefs.setString(key, codec.encode(next));
  }
}
