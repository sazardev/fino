import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/ids/id_generator_provider.dart';
import '../../../../../core/time/clock_provider.dart';
import '../../../data/orders_repository_provider.dart';
import '../../../domain/commands/undo_confirmation_command.dart';

part 'undo_confirmation_command_provider.g.dart';

@riverpod
UndoConfirmationCommand undoConfirmationCommand(Ref ref) =>
    UndoConfirmationCommand(
      ref.watch(ordersRepositoryProvider),
      ref.watch(teamDirectoryProvider),
      ref.watch(idGeneratorProvider),
      ref.watch(clockProvider),
    );
