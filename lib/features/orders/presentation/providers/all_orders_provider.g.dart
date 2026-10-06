// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_orders_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Todos los pedidos de mis equipos (SPEC §7.1: el equipo los ve todos).

@ProviderFor(allOrders)
final allOrdersProvider = AllOrdersProvider._();

/// Todos los pedidos de mis equipos (SPEC §7.1: el equipo los ve todos).

final class AllOrdersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrderSummary>>,
          List<OrderSummary>,
          Stream<List<OrderSummary>>
        >
    with
        $FutureModifier<List<OrderSummary>>,
        $StreamProvider<List<OrderSummary>> {
  /// Todos los pedidos de mis equipos (SPEC §7.1: el equipo los ve todos).
  AllOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allOrdersHash();

  @$internal
  @override
  $StreamProviderElement<List<OrderSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<OrderSummary>> create(Ref ref) {
    return allOrders(ref);
  }
}

String _$allOrdersHash() => r'5c149a87768187624579f1e6264f7418658dd3f4';
