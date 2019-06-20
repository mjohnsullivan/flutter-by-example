// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:math' show Random;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: 'Limited Box Demo',
      color: Color(0xFFFFFFFF),
      builder: (context, _) => MyHomePage3(),
    );
  }
}

class MyHomePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue,
        height: 300,
        width: 300,
        child: LimitedBox(
          maxHeight: 150,
          maxWidth: 150,
          child: Container(
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

class MyHomePage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < 10; i++)
          LimitedBox(
            maxHeight: 200,
            child: Container(
              color: getRandomColor(),
            ),
          ),
      ],
    );
  }
}

final random = Random();

/// Returns a random color, with minumim brightness level
Color getRandomColor({int minBrightness = 50}) {
  assert(minBrightness >= 0 && minBrightness <= 255);
  return Color.fromARGB(
    0xFF,
    minBrightness + random.nextInt(255 - minBrightness),
    minBrightness + random.nextInt(255 - minBrightness),
    minBrightness + random.nextInt(255 - minBrightness),
  );
}

class MyHomePage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LimitedBox(
          maxHeight: 500,
          child: ListView(
            children: [
              for (var i = 0; i < 10; i++)
                LimitedBox(
                  maxHeight: 200,
                  child: Container(
                    color: getRandomColor(),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: LimitedBox(
            maxWidth: 100, // this is ignored in this context
            maxHeight: 100, // this is ignored in this context
            child: Container(
              color: Color(0xFF0000AA),
              child: Center(
                child: Text('This is a height & width constrained LimitedBox'),
              ),
            ),
          ),
        ),
        Flexible(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var i = 0; i < 10; i++)
                LimitedBox(
                  maxHeight: 100, // this is ignored in this context
                  maxWidth:
                      100, // this is used here as horizontal height is unconstrained
                  child: Container(
                    color: Color(0xFFAA0000),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                            'This is a height only constrained LimitedBox'),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Flexible(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: [
                for (var i = 0; i < 10; i++)
                  LimitedBox(
                    maxHeight:
                        100, // this is used here as vertical height is uncontrained
                    maxWidth: 100, // this is ignored in this context
                    child: Container(
                      color: Color(0xFF00AA00),
                      child: Center(
                        child:
                            Text('This is a width only constrained LimitedBox'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        ///
        Flexible(
          child: Column(children: [
            Flexible(
              child: LimitedBox(
                maxHeight: 25,
                child: Container(
                  color: Color(0xFFAAAAAA),
                  height: 1000,
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
