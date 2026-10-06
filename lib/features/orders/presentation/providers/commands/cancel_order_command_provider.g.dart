// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_order_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cancelOrderCommand)
final cancelOrderCommandProvider = CancelOrderCommandProvider._();

final class CancelOrderCommandProvider
    extends
        $FunctionalProvider<
          CancelOrderCommand,
          CancelOrderCommand,
          CancelOrderCommand
        >
    with $Provider<CancelOrderCommand> {
  CancelOrderCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cancelOrderCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cancelOrderCommandHash();

  @$internal
  @override
  $ProviderElement<CancelOrderCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CancelOrderCommand create(Ref ref) {
    return cancelOrderCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CancelOrderCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CancelOrderCommand>(value),
    );
  }
}

String _$cancelOrderCommandHash() =>
    r'e20a6a2ff17536a44a5bb9ad1281ad0cc544b35a';
