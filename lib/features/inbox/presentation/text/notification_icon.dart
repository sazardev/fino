import 'package:flutter/material.dart';

import '../../../../core/notifications/intent/notification_kind.dart';

/// El ícono de cada tipo de notificación.
abstract final class NotificationIcon {
  static IconData of(NotificationKind kind) => switch (kind) {
    NotificationKind.orderDebtCreated ||
    NotificationKind.debtAddedToOrder => Icons.receipt_long_rounded,
    NotificationKind.debtAmountChanged => Icons.edit_rounded,
    NotificationKind.paymentReported ||
    NotificationKind.paymentAwaitingConfirmation => Icons.payments_rounded,
    NotificationKind.paymentRetracted ||
    NotificationKind.confirmationUndone => Icons.undo_rounded,
    NotificationKind.paymentReviewed => Icons.task_alt_rounded,
    NotificationKind.debtCancelled ||
    NotificationKind.orderCancelled => Icons.block_rounded,
    NotificationKind.notice => Icons.campaign_rounded,
    NotificationKind.debtObjected => Icons.feedback_rounded,
    NotificationKind.memberJoined => Icons.waving_hand_rounded,
  };
}
