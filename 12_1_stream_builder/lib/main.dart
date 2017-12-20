// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Taken from Gavin's talk at ReactiveConf
// https://www.youtube.com/watch?v=X9iqnovPGyY&feature=youtu.be&t=46m47s

import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_driver/driver_extension.dart';

void main() {
  // enableFlutterDriverExtension();
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

  @override
  void initState() {
    super.initState();
    clickStreamController = new StreamController<int>.broadcast();
    var counter = 0;
    clickStream = clickStreamController.stream.map((val) {
      counter += val;
      return counter;
    });

  }

  @override build(BuildContext context) {
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
            // StreamBuilder auto handles subscribing, unsubscribing and calls to setState
            new StreamBuilder(stream: clickStream, 
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) =>
                new Text(
                  '${snapshot?.data ?? 0}',
                  style: Theme.of(context).textTheme.display1,
              )
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => clickStreamController.add(1),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), 
    );
  }

}
