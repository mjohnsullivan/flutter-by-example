// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Taken from Gavin's talk at ReactiveConf
// https://www.youtube.com/watch?v=X9iqnovPGyY&feature=youtu.be&t=46m47s
// Demonstrates how to use streams to handle state changes

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // Uncomment to run driver tests
  enableFlutterDriverExtension();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<int> clickStreamController;
  Stream<int> clickStream;

  // First method
  StreamSubscription<int> clickSubscription;

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Create a controller for a stream that can broadcast
    clickStreamController = new StreamController<int>.broadcast();
    clickStream = clickStreamController.stream;
    // Subscribe to changes in the stream and update state when changes come through
    clickSubscription = clickStream.listen((int val) {
      setState(() {
        _counter += val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        // Add an event to the click stream
        onPressed: () => clickStreamController.add(1),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    clickSubscription.cancel();
  }
}
