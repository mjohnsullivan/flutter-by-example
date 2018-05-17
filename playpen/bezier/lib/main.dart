import 'package:bezier/lines.dart';
import 'package:bezier/wavypic.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Painting Tests'),
      ),
      body: Examples(),
    );
  }
}

class CurvedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: ClipPath(
        child: Container(height: 50.0, color: Theme.of(context).primaryColor),
        clipper: BottomWaveClipper(),
      ),
    );
  }
}

class Examples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CurvedContainer(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(width: 100.0, height: 100.0, child: LinePatterns()),
              WavyPic(),
            ],
          ),
        ),
      ],
    );
  }
}
