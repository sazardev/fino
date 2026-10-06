/// Por qué una regla de avisos rechazó el envío.
enum NoticeFailureReason {
  senderNotMember,
  noRecipients,
  recipientNotMember,
  cannotNoticeSelf,
  textRequired,
  textTooLong,
}
