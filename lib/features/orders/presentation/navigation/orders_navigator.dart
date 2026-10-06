/// A dónde lleva cada acción de las pantallas de pedidos. Lo implementa la
/// app con sus rutas: el feature no conoce URLs.
abstract interface class OrdersNavigator {
  void openOrder(String orderId);

  void openCounterpart(String teamId, String userId);

  void openPay(String teamId, String creditorId);

  void openPayment(String paymentId);

  void openNewOrder();

  /// Cierra el formulario y muestra el pedido recién creado.
  void showCreatedOrder(String orderId);

  /// Configurar mi cuenta de cobro en [teamId] (SPEC M2).
  void openPayoutSetup(String teamId);

  void openEditOrder(String orderId);

  void openAddDebtor(String orderId);

  /// Escribir un aviso a [recipientIds] (SPEC §8).
  void openNotice(String teamId, List<String> recipientIds);

  /// Crear un equipo o entrar a uno (cuando aún no hay ninguno).
  void openCreateTeam();

  void openJoinTeam();
}
