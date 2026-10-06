import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../core/time/clock_provider.dart';
import '../../../../ui/feedback/app_toast.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../../../ui/templates/settings_shell.dart';
import '../../domain/entities/notice_content.dart';
import '../../domain/enums/notice_template.dart';
import '../providers/commands/send_notice_command_provider.dart';
import '../text/describe_notice_error.dart';
import '../text/notice_result_text.dart';
import '../widgets/message_picker.dart';
import '../widgets/recipient_picker.dart';

/// "Nuevo aviso": recordar o avisar algo a miembros del equipo (SPEC §8).
class NoticeComposePage extends ConsumerStatefulWidget {
  const new({
    required this.teamId,
    super.key,
    this.recipients = const [],
    this.onBack,
  });

  final String teamId;
  final List<String> recipients;
  final VoidCallback? onBack;

  @override
  ConsumerState<NoticeComposePage> createState() => _NoticeComposePageState();
}

class _NoticeComposePageState extends ConsumerState<NoticeComposePage> {
  late Set<String> _to = widget.recipients.toSet();
  NoticeTemplate? _template = NoticeTemplate.askIfPaid;
  final _text = TextEditingController();
  var _busy = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() => _busy = true);
    await runAction(context, () async {
      final template = _template;
      final result = await ref.read(sendNoticeCommandProvider)(
        senderId: ref.read(sessionUserIdProvider)!,
        teamId: widget.teamId,
        recipientIds: _to.toList(),
        content: template != null
            ? NoticeContent.fromTemplate(template)
            : NoticeContent.custom(_text.text),
      );
      if (!mounted) return;
      final now = ref.read(clockProvider)();
      AppToast.show(context, NoticeResultText.of(result, now: now));
      widget.onBack?.call();
    }, describe: describeNoticeError);
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsShell(
      title: 'Nuevo aviso',
      onBack: widget.onBack,
      children: [
        const SectionHeader('Para'),
        RecipientPicker(
          teamId: widget.teamId,
          selected: _to,
          onChanged: (to) => setState(() => _to = to),
        ),
        const SectionHeader('Mensaje'),
        MessagePicker(
          template: _template,
          controller: _text,
          onTemplate: (t) => setState(() => _template = t),
        ),
        AppButton(
          label: 'Enviar aviso',
          icon: Icons.send_rounded,
          busy: _busy,
          onPressed: _to.isEmpty ? null : _send,
        ),
      ],
    );
  }
}
