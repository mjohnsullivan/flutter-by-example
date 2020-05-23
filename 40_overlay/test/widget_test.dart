import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:overlay/main.dart';

void main() {
  testWidgets('Overlay is displayed when button clicked',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Show Overlay'), findsOneWidget);
    expect(find.text('I am an overlay'), findsNothing);

    await tester.tap(find.byType(FlatButton));
    await tester.pump();

    expect(find.text('Hide Overlay'), findsOneWidget);
    expect(find.text('I am an overlay'), findsOneWidget);

    await tester.tap(find.byType(FlatButton));
    await tester.pump();

    expect(find.text('Show Overlay'), findsOneWidget);
    expect(find.text('I am an overlay'), findsNothing);
  });
}
