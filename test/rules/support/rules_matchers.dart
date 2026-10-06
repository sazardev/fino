import 'package:flutter_test/flutter_test.dart';

import 'firestore_rest.dart';

/// La petición pasó las reglas.
final Matcher isAllowed = isA<RestResult>().having(
  (r) => r.allowed,
  'allowed',
  isTrue,
);

/// Las reglas rechazaron la petición (403).
final Matcher isDenied = isA<RestResult>().having(
  (r) => r.denied,
  'denied',
  isTrue,
);
