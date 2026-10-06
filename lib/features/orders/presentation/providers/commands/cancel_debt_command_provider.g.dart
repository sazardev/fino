// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_debt_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cancelDebtCommand)
final cancelDebtCommandProvider = CancelDebtCommandProvider._();

final class CancelDebtCommandProvider
    extends
        $FunctionalProvider<
          CancelDebtCommand,
          CancelDebtCommand,
          CancelDebtCommand
        >
    with $Provider<CancelDebtCommand> {
  CancelDebtCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cancelDebtCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cancelDebtCommandHash();

  @$internal
  @override
  $ProviderElement<CancelDebtCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CancelDebtCommand create(Ref ref) {
    return cancelDebtCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CancelDebtCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CancelDebtCommand>(value),
    );
  }
}

String _$cancelDebtCommandHash() => r'dee9119714f707c806306cda58cf57fc2835e7d8';
