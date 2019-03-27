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
          title: Text('This is a magical disappearing app bar'),
          snap: true,
          floating: true,
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
