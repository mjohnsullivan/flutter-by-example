import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bottom_nav_bar/main.dart';

void main() {
  testWidgets('Page renders', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    // Verify that 'Index: 0' is displayed
    expect(find.text('First'), findsNWidgets(1));
    expect(find.text('Second'), findsNWidgets(1));
    expect(find.text('Index: 0'), findsNWidgets(1));
    // Tap the right nav button
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();
    // Verify that 'Index: 1' is now displayed
    expect(find.text('First'), findsNWidgets(1));
    expect(find.text('Second'), findsNWidgets(1));
    expect(find.text('Index: 1'), findsNWidgets(1));
  });
}
