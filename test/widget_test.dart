import 'package:flutter_test/flutter_test.dart';
import 'package:tourist_app/core/routing/app_router.dart';

import 'package:tourist_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(appRouter: AppRouter()));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
