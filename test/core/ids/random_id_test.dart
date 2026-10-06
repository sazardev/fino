import 'dart:math';

import 'package:fino/core/ids/random_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ids have 20 alphanumeric characters', () {
    final id = randomId();

    expect(id, hasLength(20));
    expect(RegExp(r'^[A-Za-z0-9]{20}$').hasMatch(id), isTrue);
  });

  test('ids do not collide in practice', () {
    final ids = {for (var i = 0; i < 5000; i++) randomId()};

    expect(ids, hasLength(5000));
  });

  test('a seeded random is deterministic', () {
    expect(randomId(Random(7)), randomId(Random(7)));
  });
}
