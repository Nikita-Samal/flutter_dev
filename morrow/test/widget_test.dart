import 'package:flutter_test/flutter_test.dart';
import 'package:morrow/app.dart';

void main() {
  testWidgets('Morrow app smoke test', (WidgetTester tester) async {
    // Build in UI-preview mode (no Firebase required for this test)
    await tester.pumpWidget(const MorrowApp(firebaseReady: false));
    expect(find.text('MORROW'), findsWidgets);
  });
}
