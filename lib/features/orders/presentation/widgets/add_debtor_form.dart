import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/directory/directory_person.dart';
import '../../../../core/format/money_parser.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/molecules/choice_pill_row.dart';
import '../../domain/failures/order_failure.dart';
import '../../domain/failures/order_failure_reason.dart';
import '../providers/commands/add_debtors_command_provider.dart';
import '../text/describe_order_error.dart';

/// Elegir a alguien más del equipo y cuánto debe (SPEC §5.5).
class AddDebtorForm extends ConsumerStatefulWidget {
  const new({
    required this.orderId,
    required this.candidates,
    super.key,
    this.onDone,
  });

  final String orderId;
  final List<DirectoryPerson> candidates;
  final VoidCallback? onDone;

  @override
  ConsumerState<AddDebtorForm> createState() => _AddDebtorFormState();
}

class _AddDebtorFormState extends ConsumerState<AddDebtorForm> {
  final _amount = TextEditingController();
  late String _person = widget.candidates.first.userId;
  var _busy = false;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _busy = true);
    final ok = await runAction(
      context,
      () {
        final amount = MoneyParser.parse(_amount.text);
        if (amount == null) {
          throw const OrderFailure(OrderFailureReason.amountNotPositive);
        }
        return ref.read(addDebtorsCommandProvider)(
          actorId: ref.read(sessionUserIdProvider)!,
          orderId: widget.orderId,
          newDebtors: {_person: amount},
        );
      },
      success: 'Agregado: ya le avisamos',
      describe: describeOrderError,
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
        ChoicePillRow<String>(
          options: [
            for (final p in widget.candidates) (p.userId, p.displayName),
          ],
          selected: _person,
          onSelected: (id) => setState(() => _person = id),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _amount,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: '¿Cuánto debe?',
            prefixText: r'$ ',
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(label: 'Agregar', busy: _busy, onPressed: _save),
      ],
    );
  }
}
