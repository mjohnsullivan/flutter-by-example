// Copyright 2019 The Chromium Authors. All rights reserved.
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
      appBar: AppBar(title: Text('Stack Example')),
      body: ExampleStack(),
    );
  }
}

class ExampleColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Flexible(flex: 2, child: Placeholder()),
      Flexible(flex: 1, child: Placeholder()),
    ]);
  }
}

class ExampleStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      // Stack takes up half the height of the screen
      heightFactor: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: <Widget>[
          // Makes the child widget fill the Stack
          Positioned.fill(
            child: FlutterLogo(),
          ),
          // Positions the child at 25, 25
          Positioned(
            top: 25,
            left: 25,
            child:
                Text('(25, 25)', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          // Positions the child 25 from bottom and 25 from right
          Positioned(
            bottom: 25,
            right: 25,
            child: Text('(-25, -25)',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          // Align a black square at the center
          Align(
            alignment: Alignment(0.0, 0.0),
            child: Container(
              height: 75.0,
              width: 75.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(width: 5),
                ),
                child: Center(
                    child: Text(
                  'Center',
                  style: TextStyle(fontWeight: FontWeight.w700),
                )),
              ),
            ),
          ),
          Align(
            // Aligns a small circle in the top left
            alignment: const Alignment(-1.0, -1.0),
            child: Container(
              width: 10,
              height: 10,
              child: Material(
                shape: CircleBorder(),
                color: Colors.black,
              ),
            ),
          ),
          Align(
            // Aligns a small circle in the bottom right
            alignment: const Alignment(1.0, 1.0),
            child: Container(
              width: 10,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // Aligns 25% in from top right
          Align(
            alignment: Alignment(0.5, -0.5),
            child:
                Text('25% in', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          // Aligns 25% in from the bottom left
          Align(
            alignment: Alignment(-0.5, 0.5),
            child:
                Text('25% in', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ]),
      ),
    );
  }
}
