import '../../domain/failures/team_failure.dart';
import '../../domain/failures/team_failure_reason.dart';

/// Qué decirle a la persona cuando una regla de equipos rechaza algo.
abstract final class TeamFailureMessage {
  static String of(TeamFailure failure) => switch (failure.reason) {
    TeamFailureReason.invalidName => 'Ponle un nombre (máx. 50 letras)',
    TeamFailureReason.invalidInviteCode =>
      'Ese código no existe o ya no sirve. Pídelo de nuevo.',
    TeamFailureReason.notMember => 'Ya no eres parte de este equipo',
    TeamFailureReason.notAdmin => 'Solo el admin puede hacerlo',
    TeamFailureReason.targetNotMember => 'Esa persona ya no está en el equipo',
    TeamFailureReason.cannotTargetSelf => 'No puedes hacerlo contigo',
    TeamFailureReason.adminMustTransfer =>
      'Pasa el rol de admin a alguien antes de salir',
    TeamFailureReason.adminMustDeleteTeam =>
      'Eres el único miembro: elimina el equipo en vez de salir',
    TeamFailureReason.hasLiveDebts => _blocking(failure),
    TeamFailureReason.invalidClabe =>
      'La CLABE debe tener 18 dígitos y ser válida',
    TeamFailureReason.invalidCard => 'La tarjeta debe tener 16 dígitos',
    TeamFailureReason.bankRequired => 'Escribe el banco de la tarjeta',
  };

  static String _blocking(TeamFailure failure) {
    final debts = failure.blocking;
    if (debts == null) return 'Hay deudas sin resolver';
    final parts = [
      if (debts.asDebtor > 0) '${debts.asDebtor} por pagar',
      if (debts.asCreditor > 0) '${debts.asCreditor} por cobrar',
    ];
    return 'Primero resuelve las deudas: ${parts.join(' y ')}';
  }
}
