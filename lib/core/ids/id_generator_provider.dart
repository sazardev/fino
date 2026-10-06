import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'id_generator.dart';
import 'random_id.dart';

part 'id_generator_provider.g.dart';

/// Quién reparte los ids de lo que se crea en este dispositivo.
@Riverpod(keepAlive: true)
IdGenerator idGenerator(Ref ref) => randomId;
