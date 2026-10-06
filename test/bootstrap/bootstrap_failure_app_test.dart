import 'package:fino/bootstrap/bootstrap_failure_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('says why startup failed', (tester) async {
    await tester.pumpWidget(
      BootstrapFailureApp(error: StateError('Firebase is not configured')),
    );

    expect(find.textContaining('Fino no pudo iniciar'), findsOneWidget);
    expect(find.textContaining('Firebase is not configured'), findsOneWidget);
  });
}
