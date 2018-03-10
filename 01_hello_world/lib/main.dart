// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/*
TextDirection is also a widget, so the following also works:

runApp(Directionality(
  textDirection: TextDirection.ltr,
  child: Center(
      child: Text(
    'Hello World',
  ))));
*/
void main() {
  runApp(Center(child: Text('Hello World!', textDirection: TextDirection.ltr)));
}
