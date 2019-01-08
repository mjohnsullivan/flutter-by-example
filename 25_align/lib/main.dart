import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Align Demo',
      home: Scaffold(body: AlignExamples()),
    );
  }
}

class AlignExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Flexible(
        flex: 1,
        child: Align(
          alignment: Alignment(0, 0),
          child: Text('Centered!'),
        ),
      ),
      Flexible(
        flex: 1,
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment(-1, -1),
            child: Text('Top Left!'),
          ),
          Align(
            alignment: Alignment(0, 0),
            child: Text('Centered!'),
          ),
          Align(
            alignment: Alignment(1, 1),
            child: Text('Bottom Right!'),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text('TopCenter!'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('TopCenter!'),
          ),
        ]),
      ),
      Flexible(
        flex: 1,
        child: Container(
            child: Align(
          alignment: Alignment(-.5, -.5),
          child: Text('25% in'),
        )),
      ),
      Flexible(
        flex: 1,
        child: Container(
            child: Align(
          alignment: Alignment(.5, .5),
          child: Text('75% in'),
        )),
      ),
    ]);
  }
}
