// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestures',
      home: Scaffold(
        appBar: AppBar(title: const Text('Gestures')),
        body: GesturesHomePage(),
      ),
    );
  }
}

class GesturesHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () => Scaffold.of(context).showSnackBar(const SnackBar(
            content: Text('Blue Tapped'),
            duration: Duration(milliseconds: 500))),
        onDoubleTap: () => Scaffold.of(context).showSnackBar(const SnackBar(
            content: Text('Blue Double Tapped'),
            duration: Duration(milliseconds: 500))),
        child: Container(
          height: 200,
          color: Colors.blue,
          child: const Center(
            child: Text('Tap Me'),
          ),
        ),
      ),
      GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Scaffold.of(context).showSnackBar(const SnackBar(
              content: Text('Tapped'), duration: Duration(milliseconds: 500))),
          child: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Flexible(flex: 1, child: Center(child: Text('Tap Me'))),
                  const Flexible(flex: 1, child: Center(child: Text('Tap Me'))),
                ],
              ))),
    ]);
  }
}
