import 'package:drift/native.dart';
import 'package:fino/core/analytics/analytics_service_provider.dart';
import 'package:fino/core/analytics/events/signed_in.dart';
import 'package:fino/core/analytics/events/signed_out.dart';
import 'package:fino/core/database/app_database.dart';
import 'package:fino/core/database/app_database_provider.dart';
import 'package:fino/core/database/outbox_operation.dart';
import 'package:fino/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:fino/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:fino/features/auth/presentation/providers/sign_in_controller.dart';
import 'package:fino/features/auth/presentation/providers/sign_out_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';
import '../../support/recording_analytics_service.dart';

void main() {
  late FakeAuthRepository auth;
  late RecordingAnalyticsService analytics;
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    auth = FakeAuthRepository();
    analytics = RecordingAnalyticsService();
    db = AppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(auth),
        analyticsServiceProvider.overrideWithValue(analytics),
        appDatabaseProvider.overrideWithValue(db),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(db.close);
  });

  test('signing in updates the session and reports it', () async {
    final session = container.listen(authStateProvider, (_, _) {});
    await container.read(signInControllerProvider.notifier).signIn();
    await pumpEventQueue();

    expect(session.read().value, testUser);
    expect(analytics.events.single, isA<SignedIn>());
  });

  test('a failed sign-in surfaces as an error state', () async {
    auth.signInError = Exception('cancelled');
    await container.read(signInControllerProvider.notifier).signIn();

    expect(container.read(signInControllerProvider).hasError, isTrue);
    expect(analytics.events, isEmpty);
  });

  test('signing out ends the session and wipes local data', () async {
    await db.outboxDao.enqueue(
      entity: 'debts',
      entityId: 'a',
      operation: OutboxOperation.create,
      now: DateTime.utc(2026),
    );

    await container.read(signOutControllerProvider.notifier).signOut();

    expect(analytics.events.single, isA<SignedOut>());
    expect(await db.outboxDao.due(DateTime.utc(2027)), isEmpty);
  });
}
