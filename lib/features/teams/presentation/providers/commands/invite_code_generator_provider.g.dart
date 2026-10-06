// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_code_generator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Códigos de invitación al azar (con `Random.secure`).

@ProviderFor(inviteCodeGenerator)
final inviteCodeGeneratorProvider = InviteCodeGeneratorProvider._();

/// Códigos de invitación al azar (con `Random.secure`).

final class InviteCodeGeneratorProvider
    extends
        $FunctionalProvider<
          InviteCodeGenerator,
          InviteCodeGenerator,
          InviteCodeGenerator
        >
    with $Provider<InviteCodeGenerator> {
  /// Códigos de invitación al azar (con `Random.secure`).
  InviteCodeGeneratorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteCodeGeneratorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteCodeGeneratorHash();

  @$internal
  @override
  $ProviderElement<InviteCodeGenerator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InviteCodeGenerator create(Ref ref) {
    return inviteCodeGenerator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteCodeGenerator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteCodeGenerator>(value),
    );
  }
}

String _$inviteCodeGeneratorHash() =>
    r'4eecf0ad866e520b1c307314598a38e06bc7880f';
