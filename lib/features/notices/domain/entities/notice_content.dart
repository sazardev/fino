import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/notice_template.dart';
import '../failures/notice_failure.dart';
import '../failures/notice_failure_reason.dart';

/// Qué dice un aviso: una plantilla rápida o texto libre (SPEC A2).
@immutable
final class NoticeContent {
  const new _internal({this.template, this.text});

  factory fromTemplate(NoticeTemplate template) =>
      NoticeContent._internal(template: template);

  /// Texto libre de 1 a [maxTextLength] caracteres.
  factory custom(String raw) {
    final text = raw.trim();
    if (text.isEmpty) {
      throw const NoticeFailure(NoticeFailureReason.textRequired);
    }
    if (text.length > maxTextLength) {
      throw const NoticeFailure(NoticeFailureReason.textTooLong);
    }
    return NoticeContent._internal(text: text);
  }

  static const maxTextLength = 200;

  final NoticeTemplate? template;
  final String? text;

  @override
  bool operator ==(Object other) =>
      other is NoticeContent &&
      other.template == template &&
      other.text == text;

  @override
  int get hashCode => Object.hash(template, text);
}
