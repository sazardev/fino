import 'package:flutter/material.dart';

import '../../../../core/directory/directory_person.dart';
import '../../../../core/money/money.dart';
import '../../../../ui/atoms/app_icon_button.dart';
import '../../../../ui/atoms/bouncy_tap.dart';
import '../../../../ui/atoms/chubby_icon.dart';
import '../../../../ui/atoms/person_avatar.dart';
import '../../../../ui/design/app_curves.dart';
import '../../../../ui/design/app_radii.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/molecules/amount_text.dart';

/// Alguien del equipo en "¿Quién te debe?": se toca para incluirlo; ya
/// incluido muestra su parte y se puede fijar a mano (el resto se reparte).
class ParticipantTile extends StatelessWidget {
  const new({
    required this.person,
    required this.selected,
    required this.fixed,
    required this.onToggle,
    required this.onEditAmount,
    super.key,
    this.amount,
  });

  final DirectoryPerson person;
  final bool selected;
  final bool fixed;
  final Money? amount;
  final VoidCallback onToggle;
  final VoidCallback onEditAmount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final amount = this.amount;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: BouncyTap(
        onTap: onToggle,
        pressedScale: 0.98,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: AppCurves.select,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primaryContainer
                : scheme.surfaceContainerHigh,
            borderRadius: AppRadii.mdRadius,
          ),
          child: Row(
            children: [
              PersonAvatar(
                name: person.displayName,
                seed: person.userId,
                photoUrl: person.photoUrl,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  person.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              if (selected && amount != null) ...[
                AmountText(amount),
                AppIconButton(
                  size: 40,
                  tooltip: fixed ? 'Cambiar monto fijo' : 'Fijar monto',
                  selected: fixed,
                  onPressed: onEditAmount,
                  icon: const Icon(Icons.push_pin_rounded, size: 18),
                ),
              ] else
                ChubbyIcon(
                  selected
                      ? Icons.check_circle_rounded
                      : Icons.add_circle_outline_rounded,
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
