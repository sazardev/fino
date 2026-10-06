part of '../app_routes.dart';

/// "Nuevo aviso" (`?para=a,b` preelige destinatarios): pantalla completa.
@TypedGoRoute<NoticeRoute>(path: '/nuevo-aviso/:teamId')
class NoticeRoute extends GoRouteData with $NoticeRoute {
  const new({required this.teamId, this.para});

  final String teamId;
  final String? para;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      AppTransitionPage(
        key: state.pageKey,
        child: NoticeComposePage(
          teamId: teamId,
          recipients: para?.split(',') ?? const [],
          onBack: BackNavigation.to(
            context,
            fallback: const HomeRoute().location,
          ),
        ),
      );
}
