import '../../domain/failures/notice_failure.dart';
import '../../domain/failures/notice_failure_reason.dart';

/// Para `runAction`: el mensaje de una regla de avisos rota, o `null`.
String? describeNoticeError(Object error) => switch (error) {
  NoticeFailure(:final reason) => switch (reason) {
    NoticeFailureReason.senderNotMember => 'Ya no eres parte del equipo',
    NoticeFailureReason.noRecipients => 'Elige a quién avisar',
    NoticeFailureReason.recipientNotMember => 'Alguien ya no está en el equipo',
    NoticeFailureReason.cannotNoticeSelf => 'No puedes avisarte a ti',
    NoticeFailureReason.textRequired => 'Escribe un mensaje o elige uno',
    NoticeFailureReason.textTooLong => 'Máximo 200 caracteres',
  },
  _ => null,
};
