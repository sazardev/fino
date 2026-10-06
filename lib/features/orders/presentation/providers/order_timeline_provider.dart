import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/session/session_user_id_provider.dart';
import '../../data/orders_repository_provider.dart';
import '../../domain/entities/ledger_entry.dart';

part 'order_timeline_provider.g.dart';

/// La bitácora del pedido tal como la puedo ver (SPEC §11).
@riverpod
Stream<List<LedgerEntry>> orderTimeline(Ref ref, String orderId) => ref
    .watch(ordersRepositoryProvider)
    .watchTimeline(orderId, ref.watch(sessionUserIdProvider) ?? '');
