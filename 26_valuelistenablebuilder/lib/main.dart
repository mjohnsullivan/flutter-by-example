// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValueListenableBuilder Demo',
      home: Scaffold(body: SafeArea(child: HomePage())),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SimpleValue(),
        SizedBox(height: 25),
        ComplexValue(),
        SizedBox(height: 25),
        AnimationValue(),
      ],
    ));
  }
}

class SimpleValue extends StatefulWidget {
  @override
  createState() => _SimpleValueState();
}

class _SimpleValueState extends State<SimpleValue> {
  final _simpleValue = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ValueListenableBuilder(
            valueListenable: _simpleValue,
            builder: (context, value, _) {
              return Text('Value: $value');
            }),
        FlatButton(
          child: Text('Increment'),
          onPressed: () => _simpleValue.value++,
        )
      ],
    );
  }
}

class ComplexValueNotifier extends ValueNotifier<String> {
  ComplexValueNotifier(String value) : super(value);

  void update() {
    value = value + '.';
  }
}

class ComplexValue extends StatefulWidget {
  @override
  createState() => _ComplexValueState();
}

class _ComplexValueState extends State<ComplexValue> {
  final _complexValue = ComplexValueNotifier('I\'ve been clicked');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ValueListenableBuilder(
            valueListenable: _complexValue,
            builder: (context, value, _) {
              return Text(value);
            }),
        FlatButton(
          child: Text('Click me'),
          onPressed: () => _complexValue.update(),
        )
      ],
    );
  }
}

class AnimationValue extends StatefulWidget {
  @override
  createState() => _AnimationValueState();
}

class _AnimationValueState extends State<AnimationValue>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      child: Container(width: 100.0, height: 100.0, color: Colors.green),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * math.pi,
          child: child,
        );
      },
    );
  }
}
