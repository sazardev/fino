import '../../../../core/ids/id_generator.dart';
import '../../../../core/time/clock.dart';
import '../entities/notice_content.dart';
import '../entities/notice_result.dart';
import '../notice_audience.dart';
import '../notices_repository.dart';
import '../use_cases/send_notice.dart';

/// El acreedor manda un aviso a uno o varios miembros (SPEC §8).
class SendNoticeCommand {
  const new(this._repo, this._audience, this._newId, this._clock);

  final NoticesRepository _repo;
  final NoticeAudience _audience;
  final IdGenerator _newId;
  final Clock _clock;

  Future<NoticeResult> call({
    required String senderId,
    required String teamId,
    required List<String> recipientIds,
    required NoticeContent content,
  }) async {
    final now = _clock();
    final result = SendNotice(_newId)(
      senderId: senderId,
      teamId: teamId,
      memberIds: await _audience.memberIds(teamId),
      recipientIds: recipientIds,
      content: content,
      owedByRecipient: await _audience.owedTo(senderId, teamId),
      lastSentAt: await _repo.lastSentAt(
        senderId,
        teamId,
        since: now.subtract(SendNotice.cooldown),
      ),
      now: now,
    );
    await _repo.apply(result);
    return result;
  }
}
