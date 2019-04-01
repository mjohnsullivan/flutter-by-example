// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' show Random;
import 'package:flutter/material.dart';

void main() => runApp(MySliverApp());

class MySliverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slivers Demo',
      home: Scaffold(body: MySliverPage()),
    );
  }
}

class MySliverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.menu, color: Colors.white),
              const SizedBox(width: 10),
              const Text('Expando Bar'),
            ]),
            background: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.green, Colors.red])),
            ),
          ),
          expandedHeight: 150,
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
                  color: getRandomColor(),
                ),
            childCount: 99,
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 50,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
              height: 50, child: Center(child: Text('I am a regular widget'))),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                Container(color: getRandomColor(), height: 150.0),
          ),
        )
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
