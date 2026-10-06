// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_debtors_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(addDebtorsCommand)
final addDebtorsCommandProvider = AddDebtorsCommandProvider._();

final class AddDebtorsCommandProvider
    extends
        $FunctionalProvider<
          AddDebtorsCommand,
          AddDebtorsCommand,
          AddDebtorsCommand
        >
    with $Provider<AddDebtorsCommand> {
  AddDebtorsCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addDebtorsCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addDebtorsCommandHash();

  @$internal
  @override
  $ProviderElement<AddDebtorsCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AddDebtorsCommand create(Ref ref) {
    return addDebtorsCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddDebtorsCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddDebtorsCommand>(value),
    );
  }
}

String _$addDebtorsCommandHash() => r'9f234642cb41224257a8938b690d55c7983972fc';
