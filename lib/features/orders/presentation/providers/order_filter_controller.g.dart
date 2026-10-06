// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_filter_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Búsqueda y filtros de la lista de pedidos (sobreviven al cambiar de
/// destino).

@ProviderFor(OrderFilterController)
final orderFilterControllerProvider = OrderFilterControllerProvider._();

/// Búsqueda y filtros de la lista de pedidos (sobreviven al cambiar de
/// destino).
final class OrderFilterControllerProvider
    extends $NotifierProvider<OrderFilterController, OrderFilter> {
  /// Búsqueda y filtros de la lista de pedidos (sobreviven al cambiar de
  /// destino).
  OrderFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderFilterControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderFilterControllerHash();

  @$internal
  @override
  OrderFilterController create() => OrderFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderFilter>(value),
    );
  }
}

String _$orderFilterControllerHash() =>
    r'2e85fe21cc2ef20e95411fddcdb1676adcaf587e';

/// Búsqueda y filtros de la lista de pedidos (sobreviven al cambiar de
/// destino).

abstract class _$OrderFilterController extends $Notifier<OrderFilter> {
  OrderFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OrderFilter, OrderFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OrderFilter, OrderFilter>,
              OrderFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
