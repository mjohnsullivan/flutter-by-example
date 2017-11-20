// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

const Duration kWaitForTransition = const Duration(milliseconds: 250);

void main() {
  testWidgets('Navigating between two screens', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(new NavigationExampleApp());

    // Expect to be on the first screen
    expect(find.text('First Screen'), findsOneWidget);
    
    // Tap the button to go to the next screen
    await tester.tap(find.text('Pass via constructor'));
    await tester.pumpAndSettle();

    // Expect to be on the second screen
    expect(find.text('Second Screen'), findsOneWidget);

    // Tap the button to go back to the first screen
    await tester.tap(find.text('Return to First'));
    await tester.pumpAndSettle();

    // Expect to be back at the first screen
    expect(find.text('First Screen'), findsOneWidget);

     // Tap the other button to go to the next screen
    await tester.tap(find.text('Pass via route'));
    await tester.pumpAndSettle();

    // Expect to be on the second screen
    expect(find.text('Second Screen'), findsOneWidget);

    // Tap the button to go back to the first screen
    await tester.tap(find.text('Return to First'));
    await tester.pumpAndSettle();

  });
}