import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/core/sync/remote_marker.dart';
import 'package:fino/core/sync/remote_write.dart';
import 'package:fino/features/orders/data/mappers/debt_mapper.dart';
import 'package:fino/features/orders/domain/entities/debt.dart';
import 'package:fino/features/orders/domain/enums/debt_status.dart';

/// Para simular un cliente tramposo: una confirmación que solo el acreedor
/// puede hacer.
abstract final class DebtMapperHack {
  static DebtsCompanion confirmed(Debt debt) =>
      DebtMapper.toCompanion(debt.copyWith(status: DebtStatus.confirmed));

  static List<RemoteWrite> illegalConfirmation(String teamId, Debt debt) => [
    RemoteWrite(
      collection: 'teams/$teamId/debts',
      id: debt.id,
      operation: OutboxOperation.update,
      fields: {
        'amount': debt.amount.cents,
        'status': 'confirmed',
        'paymentId': RemoteMarker.fieldDelete,
        'updatedAt': RemoteMarker.serverTimestamp,
      },
    ),
  ];
}
