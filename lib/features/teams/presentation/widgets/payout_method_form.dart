import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/molecules/flat_segmented_button.dart';
import '../../domain/entities/card_payout.dart';
import '../../domain/entities/clabe_payout.dart';
import '../../domain/entities/payout_method.dart';
import '../providers/commands/set_payout_method_command_provider.dart';
import '../text/describe_team_error.dart';

/// CLABE o tarjeta + banco, y el titular (SPEC M1). Se valida el formato
/// (dígito verificador de la CLABE) antes de guardar (M3).
class PayoutMethodForm extends ConsumerStatefulWidget {
  const new({required this.teamId, super.key, this.current, this.onDone});

  final String teamId;
  final PayoutMethod? current;
  final VoidCallback? onDone;

  @override
  ConsumerState<PayoutMethodForm> createState() => _PayoutMethodFormState();
}

class _PayoutMethodFormState extends ConsumerState<PayoutMethodForm> {
  late var _isClabe = widget.current is! CardPayout;
  late final _number = TextEditingController(
    text: switch (widget.current) {
      ClabePayout(:final clabe) => clabe,
      CardPayout(:final cardNumber) => cardNumber,
      _ => '',
    },
  );
  late final _bank = TextEditingController(text: widget.current?.bankName);
  late final _holder = TextEditingController(text: widget.current?.holderName);
  var _busy = false;

  @override
  void dispose() {
    _number.dispose();
    _bank.dispose();
    _holder.dispose();
    super.dispose();
  }

  String? _optional(TextEditingController c) =>
      c.text.trim().isEmpty ? null : c.text.trim();

  Future<void> _save() async {
    setState(() => _busy = true);
    final ok = await runAction(
      context,
      () {
        final method = _isClabe
            ? ClabePayout.parse(
                _number.text,
                bankName: _optional(_bank),
                holderName: _optional(_holder),
              )
            : CardPayout.parse(
                _number.text,
                bankName: _bank.text,
                holderName: _optional(_holder),
              );
        return ref.read(setPayoutMethodCommandProvider)(
          userId: ref.read(sessionUserIdProvider)!,
          teamId: widget.teamId,
          method: method,
        );
      },
      success: 'Cuenta guardada',
      describe: describeTeamError,
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) widget.onDone?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlatSegmentedButton<bool>(
          segments: const [(true, 'CLABE'), (false, 'Tarjeta')],
          selected: _isClabe,
          onChanged: (value) => setState(() => _isClabe = value),
        ),
        const SizedBox(height: AppSpacing.lg),
        TextField(
          controller: _number,
          keyboardType: TextInputType.number,
          maxLength: _isClabe ? 22 : 19,
          decoration: InputDecoration(
            labelText: _isClabe ? 'CLABE (18 dígitos)' : 'Tarjeta (16 dígitos)',
          ),
        ),
        TextField(
          controller: _bank,
          decoration: InputDecoration(
            labelText: _isClabe ? 'Banco (opcional)' : 'Banco',
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _holder,
          decoration: const InputDecoration(labelText: 'Titular (opcional)'),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Solo la ve quien te deba algo, y solo al pagarte.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(label: 'Guardar cuenta', busy: _busy, onPressed: _save),
      ],
    );
  }
}
