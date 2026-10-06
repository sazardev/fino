// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_by_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Los pedidos por id, para nombrar deudas por su concepto.

@ProviderFor(ordersById)
final ordersByIdProvider = OrdersByIdProvider._();

/// Los pedidos por id, para nombrar deudas por su concepto.

final class OrdersByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, Order>>,
          Map<String, Order>,
          FutureOr<Map<String, Order>>
        >
    with
        $FutureModifier<Map<String, Order>>,
        $FutureProvider<Map<String, Order>> {
  /// Los pedidos por id, para nombrar deudas por su concepto.
  OrdersByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersByIdHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, Order>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Order>> create(Ref ref) {
    return ordersById(ref);
  }
}

String _$ordersByIdHash() => r'2bb2648f7cc58cdf3244545c7898715b3511466c';
