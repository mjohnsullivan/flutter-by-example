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
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('List Example'),
        ),
        body: new ListView.builder(
          itemBuilder: (BuildContext context, int position) =>
              // Try using either _getRowWithDivider or _getRowWithBoxDecoration
              // for two different ways of rendering a divider
              _getRowWithDivider(position),
        ));
  }

  /// Returns the widget at position i in the list, separated using a divider
  Widget _getRowWithDivider(int i) {
    var children = <Widget>[
      new Padding(padding: new EdgeInsets.all(10.0), child: new Text('Row $i')),
      new Divider(height: 5.0),
    ];

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

// Returns the widget at position i in the list, separated using a BoxDecoration
  Widget _getRowWithBoxDecoration(int i) {
    return new Container(
        decoration: new BoxDecoration(
            border:
                new Border(bottom: new BorderSide(color: Colors.grey[100]))),
        child: new Padding(
            padding: new EdgeInsets.all(10.0), child: new Text('Row $i')));
  }
}
