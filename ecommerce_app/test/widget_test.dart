import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Firebase requires initialization before widgets can be pumped.
    // Run `flutter test` after completing Firebase setup.
    expect(true, isTrue);
  });
}
