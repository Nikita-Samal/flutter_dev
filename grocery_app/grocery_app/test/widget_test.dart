import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_ui/main.dart';

void main() {
  testWidgets('renders grocery home', (tester) async {
    await tester.pumpWidget(const GroceryApp());

    expect(find.text('Freshness at your door.'), findsOneWidget);
    expect(find.text('Popular near you'), findsOneWidget);
    expect(find.text('Shop now'), findsOneWidget);
    expect(find.text('Search for groceries'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Cart'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}