import 'package:flutter_test/flutter_test.dart';

import '../../tool/src/version_bump.dart';

const _pubspec =
    'name: fino\nversion: 1.4.7+12\nenvironment:\n  sdk: ^3.13.4\n';

void main() {
  test('major resets minor and patch', () {
    final bump = bumpPubspecVersion(_pubspec, BumpPart.major);
    expect(bump.from, '1.4.7+12');
    expect(bump.to, '2.0.0+13');
  });

  test('minor resets patch', () {
    expect(bumpPubspecVersion(_pubspec, BumpPart.minor).to, '1.5.0+13');
  });

  test('patch only moves patch', () {
    expect(bumpPubspecVersion(_pubspec, BumpPart.patch).to, '1.4.8+13');
  });

  test('rewrites only the version line', () {
    final bump = bumpPubspecVersion(_pubspec, BumpPart.patch);
    expect(
      bump.pubspec,
      'name: fino\nversion: 1.4.8+13\nenvironment:\n  sdk: ^3.13.4\n',
    );
  });

  test('a pubspec without a version is a FormatException', () {
    expect(
      () => bumpPubspecVersion('name: fino\n', BumpPart.patch),
      throwsFormatException,
    );
  });
}
