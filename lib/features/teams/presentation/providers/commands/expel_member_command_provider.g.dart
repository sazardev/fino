// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expel_member_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(expelMemberCommand)
final expelMemberCommandProvider = ExpelMemberCommandProvider._();

final class ExpelMemberCommandProvider
    extends
        $FunctionalProvider<
          ExpelMemberCommand,
          ExpelMemberCommand,
          ExpelMemberCommand
        >
    with $Provider<ExpelMemberCommand> {
  ExpelMemberCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expelMemberCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expelMemberCommandHash();

  @$internal
  @override
  $ProviderElement<ExpelMemberCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExpelMemberCommand create(Ref ref) {
    return expelMemberCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExpelMemberCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExpelMemberCommand>(value),
    );
  }
}

String _$expelMemberCommandHash() =>
    r'259c99ef6d2dd715545f983a161c0e17415bdc6f';
