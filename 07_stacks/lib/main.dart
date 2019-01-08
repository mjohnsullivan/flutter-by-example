// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stack Demo',
      home: StackExamplePage(),
    );
  }
}

class StackExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: Text('Stack Example')),
        body: _createStack());
  }

  _createStack() {
    return Stack(children: <Widget>[
      Image.network(
        'https://i.imgur.com/FsXL8vI.jpg',
      ),
      // Black square centered in stack
      Align(
        alignment: Alignment(0.0, 0.0),
        child: Container(
          height: 50.0,
          width: 50.0,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.black),
          ),
        ),
      ),
      Align(
        // alignment: Alignment.topLeft,
        alignment: const Alignment(-1.0, -1.0),
        child: Text('Top Left', style: TextStyle(color: Colors.yellow)),
      ),
      Align(
        // alignment: Alignment.bottomRight,
        alignment: const Alignment(1.0, 1.0),
        child: Text('Bottom Right', style: TextStyle(color: Colors.yellow)),
      ),
      Align(
        alignment: Alignment(-0.8, -0.8),
        child: Text('10% in', style: TextStyle(color: Colors.yellow)),
      ),
      Align(
        alignment: Alignment(0.8, 0.8),
        child: Text('90% in', style: TextStyle(color: Colors.yellow)),
      ),
    ]);
  }
}
