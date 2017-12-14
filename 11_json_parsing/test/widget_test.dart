import 'package:flutter_test/flutter_test.dart';

import 'package:json_parsing/main.dart';

void main() {
  testWidgets('Page renders', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    expect(find.text('List Example'), findsOneWidget);

    // Wait for timers to complete
    await tester.idle();
  });
}
