// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

final style = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Constrained App'),
        ),
        body: DefaultTextStyle(style: style, child: ConstrainedExamples()),
      ),
    );
  }
}

class ConstrainedExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 200,
            ),
            child: Text(
              'You should really press the button below',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 100,
            ),
            child: RaisedButton(
              child: Text('Tap Me!', style: style),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
