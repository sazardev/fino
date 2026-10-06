import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/format/money_format.dart';
import '../../../../core/money/money.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/design/app_spacing.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/amount_text.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../domain/entities/debt.dart';
import '../providers/commands/report_payment_command_provider.dart';
import '../text/describe_order_error.dart';

/// El cierre de *Pagar*: total, referencia opcional y "Ya pagué" (G3, D3).
class PayConfirmSection extends ConsumerStatefulWidget {
  const new({
    required this.selected,
    required this.creditorName,
    required this.canReport,
    super.key,
    this.onDone,
  });

  final List<Debt> selected;
  final String creditorName;

  /// Sin la cuenta a la vista no se puede reportar (M5 guarda cuál se vio).
  final bool canReport;
  final VoidCallback? onDone;

  @override
  ConsumerState<PayConfirmSection> createState() => _PayConfirmSectionState();
}

class _PayConfirmSectionState extends ConsumerState<PayConfirmSection> {
  final _reference = TextEditingController();
  var _busy = false;

  @override
  void dispose() {
    _reference.dispose();
    super.dispose();
  }

  Future<void> _report() async {
    setState(() => _busy = true);
    final ok = await runAction(
      context,
      () => ref.read(reportPaymentCommandProvider)(
        actorId: ref.read(sessionUserIdProvider)!,
        debtIds: [for (final d in widget.selected) d.id],
        shownAmounts: {for (final d in widget.selected) d.id: d.amount},
        reference: _reference.text,
      ),
      success: 'Listo: le avisamos a ${widget.creditorName}',
      describe: describeOrderError,
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) widget.onDone?.call();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final total = Money.sum(widget.selected.map((d) => d.amount));

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text('Total', style: text.titleMedium)),
              AmountText(total, style: text.headlineSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _reference,
            maxLength: 100,
            decoration: const InputDecoration(
              labelText: 'Referencia (opcional)',
              hintText: 'Clave de rastreo, folio…',
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Ya pagué ${MoneyFormat.format(total)}',
            icon: Icons.check_rounded,
            busy: _busy,
            onPressed: widget.canReport && total.isPositive ? _report : null,
          ),
        ],
      ),
    );
  }
}
