// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_debt_amount_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateDebtAmountCommand)
final updateDebtAmountCommandProvider = UpdateDebtAmountCommandProvider._();

final class UpdateDebtAmountCommandProvider
    extends
        $FunctionalProvider<
          UpdateDebtAmountCommand,
          UpdateDebtAmountCommand,
          UpdateDebtAmountCommand
        >
    with $Provider<UpdateDebtAmountCommand> {
  UpdateDebtAmountCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateDebtAmountCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateDebtAmountCommandHash();

  @$internal
  @override
  $ProviderElement<UpdateDebtAmountCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateDebtAmountCommand create(Ref ref) {
    return updateDebtAmountCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateDebtAmountCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateDebtAmountCommand>(value),
    );
  }
}

String _$updateDebtAmountCommandHash() =>
    r'53531451fe38f7ec63f7dfc3a5ff70d6d25d37c9';
