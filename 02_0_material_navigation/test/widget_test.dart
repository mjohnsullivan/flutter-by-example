// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:navigation_example/main.dart';

const Duration kWaitForTransition = const Duration(milliseconds: 250);

void main() {
  testWidgets('Navigating between two screens', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(NavigationExampleApp());

    // Expect to be on the first screen
    expect(find.text('First Screen'), findsOneWidget);

    // Tap the button to go to the next screen
    await tester.tap(find.text('Go to Second'));
    await tester.pumpAndSettle();

    // Expect to be on the second screen
    expect(find.text('Second Screen'), findsOneWidget);

    // Tap the button to go back to the first screen
    await tester.tap(find.text('Go to First'));
    await tester.pumpAndSettle();

    // Expect to be back at the first screen
    expect(find.text('First Screen'), findsOneWidget);
  });
}
