// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_orders_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// La lista de pedidos ya filtrada: estado, equipo, "solo míos" y búsqueda
/// por concepto, nota o nombre de quien pagó (sin acentos ni mayúsculas).

@ProviderFor(filteredOrders)
final filteredOrdersProvider = FilteredOrdersProvider._();

/// La lista de pedidos ya filtrada: estado, equipo, "solo míos" y búsqueda
/// por concepto, nota o nombre de quien pagó (sin acentos ni mayúsculas).

final class FilteredOrdersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrderSummary>>,
          List<OrderSummary>,
          FutureOr<List<OrderSummary>>
        >
    with
        $FutureModifier<List<OrderSummary>>,
        $FutureProvider<List<OrderSummary>> {
  /// La lista de pedidos ya filtrada: estado, equipo, "solo míos" y búsqueda
  /// por concepto, nota o nombre de quien pagó (sin acentos ni mayúsculas).
  FilteredOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredOrdersHash();

  @$internal
  @override
  $FutureProviderElement<List<OrderSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrderSummary>> create(Ref ref) {
    return filteredOrders(ref);
  }
}

String _$filteredOrdersHash() => r'b11240289dc63d9c0dd0bab4d044f984e6b40ca6';
