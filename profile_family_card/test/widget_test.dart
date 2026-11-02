import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_family_card/model/family_member.dart';
import 'package:profile_family_card/widgets/family_member_card.dart';

void main() {
  testWidgets('FamilyMemberCard displays member name and relation',
          (WidgetTester tester) async {
        const member = FamilyMember(
          name: 'John',
          relation: 'Father',
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: FamilyMemberCard(member: member, name: '', relation: '',),
            ),
          ),
        );

        expect(find.text('John'), findsOneWidget);
        expect(find.text('Father'), findsOneWidget);
        expect(find.byIcon(Icons.person), findsOneWidget);
      });
}