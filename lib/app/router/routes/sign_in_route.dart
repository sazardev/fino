part of '../app_routes.dart';

@TypedGoRoute<SignInRoute>(path: signInPath)
class SignInRoute extends GoRouteData with $SignInRoute {
  const new({this.from});

  /// Where to go once signed in.
  final String? from;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(key: state.pageKey, child: const SignInPage());
}
