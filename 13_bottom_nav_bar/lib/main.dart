// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Adapted from https://stackoverflow.com/questions/45235570/how-to-use-bottomnavigationbar-with-navigator

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Bottom Nav Demo',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      // home: new BottomNavigationDemo(),
      home: new BottomNavExample()
    );
  }
}

class BottomNavExample extends StatefulWidget {
  @override
  BottomNavExampleState createState() => new BottomNavExampleState();
}

class BottomNavExampleState extends State<BottomNavExample> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          // OffStage widgets can be hidden
          new Offstage(
            offstage: index != 0,
            child: new Container(
              child: new Center(
                child: new Text('Left',
                style: Theme.of(context).textTheme.display2)
              )
            ),
          ),
          new Offstage(
            offstage: index != 1,
            child: new Container(
              child: new Center(
                child: new Text('Right',
                style: Theme.of(context).textTheme.display2)
              )
            ),
          ),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) => setState(() => this.index = index),
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Left'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Right'),
          ),
        ],
      ),
    );
  }
}