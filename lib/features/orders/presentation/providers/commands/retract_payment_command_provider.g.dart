// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retract_payment_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(retractPaymentCommand)
final retractPaymentCommandProvider = RetractPaymentCommandProvider._();

final class RetractPaymentCommandProvider
    extends
        $FunctionalProvider<
          RetractPaymentCommand,
          RetractPaymentCommand,
          RetractPaymentCommand
        >
    with $Provider<RetractPaymentCommand> {
  RetractPaymentCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'retractPaymentCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$retractPaymentCommandHash();

  @$internal
  @override
  $ProviderElement<RetractPaymentCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RetractPaymentCommand create(Ref ref) {
    return retractPaymentCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RetractPaymentCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RetractPaymentCommand>(value),
    );
  }
}

String _$retractPaymentCommandHash() =>
    r'6428a3ca79e119533f35c0393b7007f296967bf1';
