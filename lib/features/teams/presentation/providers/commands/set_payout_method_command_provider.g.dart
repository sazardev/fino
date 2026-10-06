// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_payout_method_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(setPayoutMethodCommand)
final setPayoutMethodCommandProvider = SetPayoutMethodCommandProvider._();

final class SetPayoutMethodCommandProvider
    extends
        $FunctionalProvider<
          SetPayoutMethodCommand,
          SetPayoutMethodCommand,
          SetPayoutMethodCommand
        >
    with $Provider<SetPayoutMethodCommand> {
  SetPayoutMethodCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setPayoutMethodCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setPayoutMethodCommandHash();

  @$internal
  @override
  $ProviderElement<SetPayoutMethodCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SetPayoutMethodCommand create(Ref ref) {
    return setPayoutMethodCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetPayoutMethodCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetPayoutMethodCommand>(value),
    );
  }
}

String _$setPayoutMethodCommandHash() =>
    r'ac8a558beea15e0166ecac172ae607ca4a4a2509';
