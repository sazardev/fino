/// Lo que se puede hacer con una deuda desde el pedido (SPEC §6.2).
enum DebtAction {
  confirm,
  reject,
  editAmount,
  cancel,
  undoConfirmation,
  pay,
  object,
  retract,
}
