import 'package:flutter/material.dart';

import '../design/app_spacing.dart';
import 'app_button.dart';
import 'app_button_tone.dart';

/// Un campo que aparece en el lugar (no hay diálogos) con "Guardar" y
/// "Cancelar". [onSave] recibe el texto tal cual.
class InlineEditor extends StatefulWidget {
  const new({
    required this.label,
    required this.saveLabel,
    required this.onSave,
    required this.onCancel,
    super.key,
    this.initial = '',
    this.hint,
    this.keyboardType,
    this.maxLength,
    this.prefixText,
  });

  final String label;
  final String saveLabel;
  final String initial;
  final String? hint;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? prefixText;
  final Future<void> Function(String value) onSave;
  final VoidCallback onCancel;

  @override
  State<InlineEditor> createState() => _InlineEditorState();
}

class _InlineEditorState extends State<InlineEditor> {
  late final _controller = TextEditingController(text: widget.initial);
  var _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _busy = true);
    try {
      await widget.onSave(_controller.text);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          autofocus: true,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          onSubmitted: (_) => _save(),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            prefixText: widget.prefixText,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            AppButton(label: widget.saveLabel, busy: _busy, onPressed: _save),
            AppButton(
              label: 'Cancelar',
              tone: AppButtonTone.tonal,
              onPressed: _busy ? null : widget.onCancel,
            ),
          ],
        ),
      ],
    );
  }
}
