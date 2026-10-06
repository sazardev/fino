import 'package:flutter/material.dart';

import '../../../ui/atoms/app_icon_button.dart';
import '../../../ui/molecules/section_header.dart';
import '../../../ui/molecules/switching_icon_button.dart';

class ButtonsSection extends StatefulWidget {
  const ButtonsSection({super.key});

  @override
  State<ButtonsSection> createState() => _ButtonsSectionState();
}

class _ButtonsSectionState extends State<ButtonsSection> {
  bool _favorite = false;
  bool _playing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader('Botones de ícono'),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            AppIconButton(
              tooltip: 'Normal',
              onPressed: () {},
              icon: const Icon(Icons.share_rounded),
            ),
            AppIconButton(
              tooltip: 'Alternar',
              selected: _favorite,
              onPressed: () => setState(() => _favorite = !_favorite),
              icon: const Icon(Icons.favorite_rounded),
            ),
            const AppIconButton(
              tooltip: 'Deshabilitado',
              icon: Icon(Icons.block_rounded),
            ),
            SwitchingIconButton(
              active: _playing,
              activeIcon: Icons.pause_rounded,
              inactiveIcon: Icons.play_arrow_rounded,
              tooltip: 'Cambiar',
              onPressed: () => setState(() => _playing = !_playing),
            ),
          ],
        ),
        const SectionHeader('Botones de texto'),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton(onPressed: () {}, child: const Text('Principal')),
            OutlinedButton(onPressed: () {}, child: const Text('Secundario')),
          ],
        ),
      ],
    );
  }
}
