import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_user_id_provider.g.dart';

/// El uid de quien está en sesión (`null` = nadie), para quien lo necesite
/// sin conocer de dónde viene la sesión. La app lo sobrescribe con el estado
/// de autenticación.
@Riverpod(keepAlive: true)
String? sessionUserId(Ref ref) => null;
