import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Fade Animation Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          body: new Blink(
              duration: const Duration(milliseconds: 1000),
              child: new Text(
                'Fader',
                style: new TextStyle(fontSize: 32.0),
              ))),
    );
  }
}

class Blink extends StatefulWidget {
  Blink({this.child, this.duration});
  final Widget child;
  final Duration duration;

  @override
  createState() => new BlinkState();
}

class BlinkState extends State<Blink> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller =
        new AnimationController(duration: widget.duration, vsync: this);
    final CurvedAnimation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = new Tween(begin: 1.0, end: 0.0).animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        controller.reverse();
      else if (status == AnimationStatus.dismissed) controller.forward();
    });
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new FadeTransition(
          opacity: animation,
          child: widget.child,
        ),
      ),
    );
  }
}
