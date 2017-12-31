import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bottom_nav_bar/main.dart';

void main() {
  testWidgets('Page renders', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());
    // Verify that 'Left' is rendered twice
    expect(find.text('Left'), findsNWidgets(2));
    // Tap the right nav button
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();
    // Verify that 'Left' is rendered once and Right' twice
    expect(find.text('Left'), findsNWidgets(1));
    expect(find.text('Right'), findsNWidgets(2));

  });
}
