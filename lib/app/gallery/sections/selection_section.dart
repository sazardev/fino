import 'package:flutter/material.dart';

import '../../../ui/atoms/app_switch.dart';
import '../../../ui/design/app_spacing.dart';
import '../../../ui/molecules/section_header.dart';
import '../../../ui/molecules/selectable_card.dart';
import '../../../ui/molecules/settings_row.dart';
import '../../../ui/molecules/value_stepper.dart';

class SelectionSection extends StatefulWidget {
  const SelectionSection({super.key});

  @override
  State<SelectionSection> createState() => _SelectionSectionState();
}

class _SelectionSectionState extends State<SelectionSection> {
  int _card = 0;
  bool _switch = true;
  int _steps = 5;

  static const _labels = ['Semanal', 'Quincenal', 'Mensual'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionHeader('Tarjetas seleccionables'),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < _labels.length; i++) ...[
                if (i > 0) const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: SelectableCard(
                    label: _labels[i],
                    subtitle: '${i + 1} opción',
                    selected: _card == i,
                    onTap: () => setState(() => _card = i),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SectionHeader('Filas y controles'),
        SettingsRow(
          label: 'Interruptor',
          subtitle: 'Con háptica propia',
          trailing: AppSwitch(
            value: _switch,
            onChanged: (v) => setState(() => _switch = v),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: ValueStepper(
            label: 'Valor',
            value: _steps,
            min: 0,
            max: 20,
            format: (v) => '$v pasos',
            onChanged: (v) => setState(() => _steps = v),
          ),
        ),
      ],
    );
  }
}
