import 'package:flutter/material.dart';

import '../atoms/app_icon_button.dart';

/// Campo de búsqueda redondo con lupa y botón para limpiar.
class SearchField extends StatefulWidget {
  const new({required this.onChanged, super.key, this.hint = 'Buscar'});

  final ValueChanged<String> onChanged;
  final String hint;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        widget.onChanged(value);
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: _controller.text.isEmpty
            ? null
            : AppIconButton(
                size: 36,
                tooltip: 'Limpiar',
                onPressed: _clear,
                icon: const Icon(Icons.close_rounded, size: 18),
              ),
      ),
    );
  }
}
