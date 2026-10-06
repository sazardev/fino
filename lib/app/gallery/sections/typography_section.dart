import 'package:flutter/material.dart';

import '../../../ui/design/app_spacing.dart';
import '../../../ui/molecules/section_header.dart';
import '../../../ui/theme/tabular_text.dart';

class TypographySection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader('Tipografía (Geist)'),
          Text('Título', style: text.headlineSmall),
          Text('Cuerpo grande', style: text.bodyLarge),
          Text(
            'Texto secundario',
            style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '1,234.56',
            style: text.headlineMedium
                ?.copyWith(fontWeight: FontWeight.w700)
                .tabular,
          ),
          Text(
            '0,000.00',
            style: text.headlineMedium
                ?.copyWith(fontWeight: FontWeight.w700)
                .tabular,
          ),
        ],
      ),
    );
  }
}
