import 'package:go_router/go_router.dart';

/// Abre una ubicación como lo pide cada destino con su propia pila: dentro
/// del mismo destino se apila (volver regresa aquí); hacia otro destino se va
/// a él con su ruta completa (volver sube a su raíz).
class RouterOpener {
  const new(this._router);

  final GoRouter _router;

  void open(String location) {
    final current = _router.routerDelegate.currentConfiguration.uri.path;
    _sameDestination(current, location)
        ? _router.push<void>(location)
        : _router.go(location);
  }

  /// Pantallas completas (formularios): siempre encima de donde se está.
  void push(String location) => _router.push<void>(location);

  void go(String location) => _router.go(location);

  static bool _sameDestination(String a, String b) => _root(a) == _root(b);

  static String _root(String path) {
    final segment = path.split('/').where((s) => s.isNotEmpty).firstOrNull;
    return switch (segment) {
      null || 'cuentas' => 'inicio',
      'pagos' => 'pedidos',
      final other => other,
    };
  }
}
