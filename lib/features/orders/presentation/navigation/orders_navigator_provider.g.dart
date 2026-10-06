// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_navigator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Lo sobrescribe la app con su router (`appProviderOverrides`).

@ProviderFor(ordersNavigator)
final ordersNavigatorProvider = OrdersNavigatorProvider._();

/// Lo sobrescribe la app con su router (`appProviderOverrides`).

final class OrdersNavigatorProvider
    extends
        $FunctionalProvider<OrdersNavigator, OrdersNavigator, OrdersNavigator>
    with $Provider<OrdersNavigator> {
  /// Lo sobrescribe la app con su router (`appProviderOverrides`).
  OrdersNavigatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ordersNavigatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ordersNavigatorHash();

  @$internal
  @override
  $ProviderElement<OrdersNavigator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrdersNavigator create(Ref ref) {
    return ordersNavigator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrdersNavigator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrdersNavigator>(value),
    );
  }
}

String _$ordersNavigatorHash() => r'afa953511ab3c5506373548e5afda3b1097e1b80';
