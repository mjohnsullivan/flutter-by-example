// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('Basic smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(TextFieldExampleApp());

    expect(find.text('Enter text; return submits'), findsOneWidget);
    expect(find.text('Enter text; return doesn\'t submit'), findsOneWidget);
  });
}
