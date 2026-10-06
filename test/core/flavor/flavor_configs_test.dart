import 'package:fino/core/flavor/configs/dev_flavor_config.dart';
import 'package:fino/core/flavor/configs/prod_flavor_config.dart';
import 'package:fino/core/flavor/configs/qa_flavor_config.dart';
import 'package:fino/core/flavor/flavor.dart';
import 'package:fino/core/flavor/flavor_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final configs = [devFlavorConfig, qaFlavorConfig, prodFlavorConfig];

  test('each entrypoint config carries its own flavor', () {
    expect(configs.map((c) => c.flavor), Flavor.values);
  });

  test('flavors are told apart by name, project and host', () {
    final fields = <String, String Function(FlavorConfig)>{
      'appName': (c) => c.appName,
      'projectId': (c) => c.firebaseOptions.projectId,
      'deepLinkHost': (c) => c.deepLinkHost,
    };
    for (final MapEntry(key: name, value: pick) in fields.entries) {
      expect(configs.map(pick).toSet(), hasLength(3), reason: name);
    }
  });

  test('only production is strict and quiet', () {
    expect(prodFlavorConfig.strictConfiguration, isTrue);
    expect(prodFlavorConfig.verboseLogging, isFalse);
    expect(devFlavorConfig.strictConfiguration, isFalse);
    expect(qaFlavorConfig.strictConfiguration, isFalse);
  });
}
