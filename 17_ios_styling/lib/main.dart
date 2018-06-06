// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
      ),
      home: MyAppleApp(),
    );
  }
}

class MyAppleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 17.0,
        letterSpacing: -0.38,
        color: CupertinoColors.black,
        decoration: TextDecoration.none,
      ),
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Flutter Demo Home Page'),
        ),
        child: Container(color: CupertinoColors.white, child: MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Text('$_counter'),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CupertinoButton(
              child: Text('Increment'),
              onPressed: _incrementCounter,
            ),
          ),
        ],
      ),
    );
  }
}
