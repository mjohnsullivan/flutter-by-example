// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Adapted from https://flutter.io/flutter-for-android/#listviews--adapters

import 'package:flutter/material.dart';

void main() {
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
      home: new ListExamplePage(),
    );
  }
}

class ListExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ListTile.divideTiles adds divider between elements in a list
    // https://docs.flutter.io/flutter/material/ListTile/divideTiles.html
    var dividedWidgetList = ListTile.divideTiles(
        context: context,
        tiles: _getListData(),
        color: Colors.black).toList();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('List Example'),
      ),
      body: new ListView(children: dividedWidgetList)
    );
  }

  _getListData() {
    List<Widget> widgets = [];
    for (int i=0; i<100; i++) {
      widgets.add(
        new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Text('Row $i'))
      );
    }
    return widgets;
  }
}
