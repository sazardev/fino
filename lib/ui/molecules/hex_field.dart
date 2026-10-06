import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// `#RRGGBB` text field that follows [color] and reports valid entries.
class HexField extends StatefulWidget {
  const HexField({
    super.key,
    required this.color,
    required this.onChanged,
    this.label = 'Hex',
  });

  final Color color;
  final ValueChanged<Color> onChanged;
  final String label;

  @override
  State<HexField> createState() => _HexFieldState();
}

class _HexFieldState extends State<HexField> {
  late final TextEditingController _controller = TextEditingController(
    text: _hexOf(widget.color),
  );

  static String _hexOf(Color c) =>
      (c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();

  @override
  void didUpdateWidget(covariant HexField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only when the color moved (a slider), so half-typed text isn't wiped.
    if (oldWidget.color != widget.color) {
      _controller.text = _hexOf(widget.color);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    if (value.length != 6) return;
    final rgb = int.tryParse(value, radix: 16);
    if (rgb != null) widget.onChanged(Color(0xFF000000 | rgb));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLength: 6,
      textCapitalization: TextCapitalization.characters,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9a-fA-F]')),
      ],
      decoration: InputDecoration(
        labelText: widget.label,
        prefixText: '#',
        counterText: '',
      ),
      onChanged: _onChanged,
    );
  }
}
