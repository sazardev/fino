import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/money/money.dart';

/// Un participante del reparto. Con [fixedAmount] su monto queda fijado y
/// el resto se recalcula con lo que sobra (SPEC §5.2).
@immutable
final class SplitEntry {
  const new(this.userId, {this.fixedAmount});

  final String userId;
  final Money? fixedAmount;

  bool get isFixed => fixedAmount != null;

  @override
  bool operator ==(Object other) =>
      other is SplitEntry &&
      other.userId == userId &&
      other.fixedAmount == fixedAmount;

  @override
  int get hashCode => Object.hash(userId, fixedAmount);
}
