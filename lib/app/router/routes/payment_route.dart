part of '../app_routes.dart';

/// Un pago agrupado (dentro de Pedidos): ahí llevan los avisos de pago.
class PaymentRoute extends GoRouteData with $PaymentRoute {
  const new({required this.paymentId});

  final String paymentId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: PaymentPage(
          paymentId: paymentId,
          onBack: BackNavigation.to(
            context,
            fallback: const OrdersRoute().location,
          ),
        ),
      );
}
