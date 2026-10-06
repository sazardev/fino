import 'package:flutter/material.dart';

import '../../../../core/notifications/notice_template_text.dart';
import '../../../../ui/atoms/choice_pill.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../domain/enums/notice_template.dart';

/// El mensaje: una plantilla rápida o texto propio (SPEC A2). Elegir una
/// borra la otra.
class MessagePicker extends StatelessWidget {
  const new({
    required this.template,
    required this.controller,
    required this.onTemplate,
    super.key,
  });

  final NoticeTemplate? template;
  final TextEditingController controller;
  final ValueChanged<NoticeTemplate?> onTemplate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final option in NoticeTemplate.values)
              ChoicePill(
                label: NoticeTemplateText.of(option.name),
                selected: template == option,
                onTap: () {
                  controller.clear();
                  onTemplate(template == option ? null : option);
                },
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: controller,
          maxLength: 200,
          minLines: 2,
          maxLines: 4,
          onChanged: (_) => onTemplate(null),
          decoration: const InputDecoration(
            labelText: 'O escribe tu mensaje',
            hintText: 'Ya paguen 🙏',
          ),
        ),
      ],
    );
  }
}
