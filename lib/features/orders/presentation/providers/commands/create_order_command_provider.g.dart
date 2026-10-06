// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_command_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(createOrderCommand)
final createOrderCommandProvider = CreateOrderCommandProvider._();

final class CreateOrderCommandProvider
    extends
        $FunctionalProvider<
          CreateOrderCommand,
          CreateOrderCommand,
          CreateOrderCommand
        >
    with $Provider<CreateOrderCommand> {
  CreateOrderCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createOrderCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createOrderCommandHash();

  @$internal
  @override
  $ProviderElement<CreateOrderCommand> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateOrderCommand create(Ref ref) {
    return createOrderCommand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateOrderCommand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateOrderCommand>(value),
    );
  }
}

String _$createOrderCommandHash() =>
    r'11c7fe2c1fd443475246117898934aaaefc4de4c';
