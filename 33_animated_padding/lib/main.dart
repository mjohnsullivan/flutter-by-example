import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: PaddedPageWithButton()),
    );
  }
}

class PaddedPageWithButton extends StatefulWidget {
  @override
  _PaddedPageWithButtonState createState() => _PaddedPageWithButtonState();
}

class _PaddedPageWithButtonState extends State<PaddedPageWithButton> {
  double cardPadding = 10;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 300,
            width: 300,
            child: AnimatedPadding(
              padding: EdgeInsets.all(cardPadding),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Card(
                color: Colors.red,
              ),
            ),
          ),
          RaisedButton(
            child: Text('Tap me!'),
            onPressed: () => setState(
              () => cardPadding = cardPadding == 10 ? 50 : 10,
            ),
          ),
        ],
      ),
    );
  }
}

class PaddedPageWithSquares extends StatefulWidget {
  @override
  _PaddedPageWithSquaresState createState() => _PaddedPageWithSquaresState();
}

class _PaddedPageWithSquaresState extends State<PaddedPageWithSquares> {
  Timer _timer;
  double _paddingValue = 10;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
        const Duration(seconds: 2),
        (t) => setState(() {
              _paddingValue = _paddingValue == 0 ? 10 : 0;
            }));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int x = 0; x < 2; x++)
          Expanded(
            child: Row(
              children: [
                for (int y = 0; y < 2; y++)
                  Expanded(
                    child: AnimatedPadding(
                      padding: EdgeInsets.all(_paddingValue),
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: Container(
                        color: getColor(x + y),
                      ),
                    ),
                  ),
              ],
            ),
          )
      ],
    );
  }
}

Color getColor(int i) => [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
    ][i];
