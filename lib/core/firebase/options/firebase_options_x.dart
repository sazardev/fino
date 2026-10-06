import 'package:firebase_core/firebase_core.dart';

/// Marks options that `tool/configure_firebase.sh` has not generated yet.
extension FirebaseOptionsX on FirebaseOptions {
  static const placeholder = 'REPLACE_ME';

  bool get isPlaceholder => apiKey == placeholder;
}
