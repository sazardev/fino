import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/format/money_parser.dart';
import '../../../../core/session/session_user_id_provider.dart';
import '../../../../ui/feedback/run_action.dart';
import '../../../../ui/molecules/app_button.dart';
import '../../../../ui/molecules/section_header.dart';
import '../../domain/entities/order.dart';
import '../../domain/failures/order_failure.dart';
import '../../domain/failures/order_failure_reason.dart';
import '../providers/commands/change_order_total_command_provider.dart';
import '../providers/commands/edit_order_details_command_provider.dart';
import '../text/describe_order_error.dart';
import 'spent_at_choice.dart';

/// Los campos editables de un pedido (SPEC §5.5) ya cargados con lo actual.
class EditOrderForm extends ConsumerStatefulWidget {
  const new({required this.order, super.key, this.onDone});

  final Order order;
  final VoidCallback? onDone;

  @override
  ConsumerState<EditOrderForm> createState() => _EditOrderFormState();
}

class _EditOrderFormState extends ConsumerState<EditOrderForm> {
  late final _concept = TextEditingController(text: widget.order.concept);
  late final _total = TextEditingController(
    text: MoneyParser.editable(widget.order.total),
  );
  late final _note = TextEditingController(text: widget.order.note ?? '');
  late DateTime _spentAt = widget.order.spentAt;
  var _busy = false;

  @override
  void dispose() {
    _concept.dispose();
    _total.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _busy = true);
    final me = ref.read(sessionUserIdProvider)!;
    final order = widget.order;
    final ok = await runAction(
      context,
      () async {
        final total = MoneyParser.parse(_total.text);
        if (total == null) {
          throw const OrderFailure(OrderFailureReason.totalNotPositive);
        }
        await ref.read(editOrderDetailsCommandProvider)(
          actorId: me,
          orderId: order.id,
          concept: _concept.text,
          note: _note.text,
          spentAt: _spentAt,
        );
        await ref.read(changeOrderTotalCommandProvider)(
          actorId: me,
          orderId: order.id,
          newTotal: total,
        );
      },
      success: 'Pedido actualizado',
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
        TextField(
          controller: _concept,
          maxLength: 80,
          decoration: const InputDecoration(labelText: '¿Qué fue?'),
        ),
        TextField(
          controller: _total,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Total',
            prefixText: r'$ ',
            helperText: 'No puede quedar debajo de lo que ya se debe',
          ),
        ),
        const SectionHeader('¿Cuándo?'),
        SpentAtChoice(
          value: _spentAt,
          onChanged: (day) => setState(() => _spentAt = day),
        ),
        TextField(
          controller: _note,
          maxLength: 200,
          decoration: const InputDecoration(labelText: 'Nota (opcional)'),
        ),
        AppButton(label: 'Guardar cambios', busy: _busy, onPressed: _save),
      ],
    );
  }
}
