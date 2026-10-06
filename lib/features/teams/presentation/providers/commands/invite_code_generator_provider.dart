import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/invite_codes.dart';

part 'invite_code_generator_provider.g.dart';

/// Códigos de invitación al azar (con `Random.secure`).
@riverpod
InviteCodeGenerator inviteCodeGenerator(Ref ref) {
  final random = Random.secure();
  return () => InviteCodes.generate(random);
}
