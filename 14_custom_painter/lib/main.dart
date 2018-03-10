import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Custom Painter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Custom Painter Demo'),
      ),
      body: new BarChart(),
    );
  }
}

class BarChart extends StatefulWidget {
  @override
  createState() => new BarChartState();
}

class BarChartState extends State<BarChart> {
  var barHeights = <int>[];

  @override
  initState() {
    super.initState();
    _fetchBarHeights();
  }

  /// Load bar chart data from a json asset file
  _fetchBarHeights() async {
    final heights = await rootBundle
        .loadStructuredData<List<int>>('assets/barchart.json', (jsonStr) async {
      final jsonList = json.decode(jsonStr);
      return (jsonList as List).map((i) => (i as int)).toList();
    });
    setState(() => barHeights = heights);
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new CustomPaint(
      painter: new BarChartPainter(barHeights),
    ));
  }
}

/// Paints a simple bar chart from an array of integers
class BarChartPainter extends CustomPainter {
  BarChartPainter(this.barHeights);
  final List<int> barHeights;

  @override
  paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    var pos = 0.0;
    barHeights.forEach((barHeight) {
      canvas.drawRect(
        new Rect.fromLTWH(pos, 10.0, 10.0, -barHeight.toDouble()),
        paint, 
      );
      pos += 12;
    });
  }

  @override
  bool shouldRepaint(BarChartPainter old) =>
      !(new ListEquality().equals(old.barHeights, barHeights));
}