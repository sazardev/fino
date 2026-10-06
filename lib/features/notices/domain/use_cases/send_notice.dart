import '../../../../core/ids/id_generator.dart';
import '../../../../core/money/money.dart';
import '../../../../core/notifications/intent/notification_intent.dart';
import '../../../../core/notifications/intent/notification_kind.dart';
import '../../../../core/notifications/intent/notification_target.dart';
import '../entities/notice_content.dart';
import '../entities/notice_record.dart';
import '../entities/notice_result.dart';
import '../entities/skipped_recipient.dart';
import '../failures/notice_failure.dart';
import '../failures/notice_failure_reason.dart';

/// El acreedor manda un aviso a uno o varios miembros (SPEC §8).
class SendNotice {
  const new(this._newId);

  /// Mínimo entre dos avisos del mismo remitente al mismo destinatario (A3).
  static const cooldown = Duration(hours: 1);

  final IdGenerator _newId;

  /// [owedByRecipient] es lo que cada destinatario le debe al remitente en
  /// deudas vivas (A4); [lastSentAt] el último aviso que le mandó a cada uno.
  NoticeResult call({
    required String senderId,
    required String teamId,
    required Set<String> memberIds,
    required List<String> recipientIds,
    required NoticeContent content,
    required Map<String, Money> owedByRecipient,
    required Map<String, DateTime> lastSentAt,
    required DateTime now,
  }) {
    final recipients = _validate(senderId, memberIds, recipientIds);
    final sent = <String>[];
    final skipped = <SkippedRecipient>[];
    for (final id in recipients) {
      final last = lastSentAt[id];
      final retryAt = last?.add(cooldown);
      if (retryAt != null && now.isBefore(retryAt)) {
        skipped.add(SkippedRecipient(id, retryAt));
      } else {
        sent.add(id);
      }
    }

    return NoticeResult(
      skipped: skipped,
      record: sent.isEmpty
          ? null
          : NoticeRecord(
              id: _newId(),
              senderId: senderId,
              teamId: teamId,
              recipientIds: sent,
              content: content,
              sentAt: now,
            ),
      notifications: [
        for (final id in sent)
          _intent(senderId, teamId, id, content, owedByRecipient[id]),
      ],
    );
  }

  List<String> _validate(
    String senderId,
    Set<String> memberIds,
    List<String> recipientIds,
  ) {
    if (!memberIds.contains(senderId)) {
      throw const NoticeFailure(NoticeFailureReason.senderNotMember);
    }
    final recipients = recipientIds.toSet().toList();
    if (recipients.isEmpty) {
      throw const NoticeFailure(NoticeFailureReason.noRecipients);
    }
    if (recipients.contains(senderId)) {
      throw const NoticeFailure(NoticeFailureReason.cannotNoticeSelf);
    }
    if (!recipients.every(memberIds.contains)) {
      throw const NoticeFailure(NoticeFailureReason.recipientNotMember);
    }
    return recipients;
  }

  /// Si el destinatario debe algo abre *Pagar* con su total; si no, el equipo.
  NotificationIntent _intent(
    String senderId,
    String teamId,
    String recipientId,
    NoticeContent content,
    Money? owed,
  ) {
    final owes = owed != null && owed.isPositive;
    return NotificationIntent(
      kind: NotificationKind.notice,
      recipientId: recipientId,
      actorId: senderId,
      teamId: teamId,
      target: owes
          ? NotificationTarget.pay(senderId)
          : NotificationTarget.team(teamId),
      amount: owes ? owed : null,
      note: content.text,
      templateKey: content.template?.name,
    );
  }
}
