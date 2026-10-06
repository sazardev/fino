import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'orders_navigator.dart';

part 'orders_navigator_provider.g.dart';

/// Lo sobrescribe la app con su router (`appProviderOverrides`).
@Riverpod(keepAlive: true)
OrdersNavigator ordersNavigator(Ref ref) =>
    throw UnimplementedError('OrdersNavigator is provided by the app');
