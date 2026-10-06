import '../../domain/failures/order_failure.dart';
import 'order_failure_message.dart';

/// Para `runAction`: el mensaje de una regla de pedidos rota, o `null`.
String? describeOrderError(Object error) =>
    error is OrderFailure ? OrderFailureMessage.of(error.reason) : null;
