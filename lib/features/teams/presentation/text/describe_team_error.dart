import '../../../../core/sync/remote_failure.dart';
import '../../domain/failures/team_failure.dart';
import 'team_failure_message.dart';

/// Para `runAction`: el mensaje de una regla de equipos rota, o de la red
/// (entrar a un equipo necesita conexión).
String? describeTeamError(Object error) => switch (error) {
  TeamFailure() => TeamFailureMessage.of(error),
  RemoteFailure(:final isTransient) when isTransient =>
    'Sin conexión: entrar a un equipo necesita internet',
  _ => null,
};
