import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Pulse Animation Example',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
          body: new Center(
              child: new PulseText('Hello world',
                  maxScale: 3.0, duration: const Duration(milliseconds: 500))),
        ));
  }
}

class PulseText extends StatefulWidget {
  PulseText(this.text, {this.maxScale, this.duration});
  final String text;
  final double maxScale;
  final Duration duration;

  @override
  createState() => new PulseTextState();
}

class PulseTextState extends State<PulseText>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double textScale = 1.0;

  initState() {
    super.initState();
    controller =
        new AnimationController(duration: widget.duration, vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    final animation = new Tween<double>(begin: 1.0, end: 3.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          controller.reverse();
        else if (status == AnimationStatus.dismissed) controller.forward();
      });
    animation.addListener(() => setState(() => textScale = animation.value));
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Text(
      widget.text,
      textScaleFactor: textScale,
    );
  }
}
