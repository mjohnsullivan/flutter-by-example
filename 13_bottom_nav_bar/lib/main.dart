// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Adapted from https://stackoverflow.com/questions/45235570/how-to-use-bottomnavigationbar-with-navigator

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Bottom Nav Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: BottomNavExample());
  }
}

class BottomNavExample extends StatefulWidget {
  @override
  createState() => BottomNavExampleState();
}

class BottomNavExampleState extends State<BottomNavExample> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body('Index: $index'),
      bottomNavigationBar: TwoItemBottomNavBar(
        index: index,
        callback: (newIndex) => setState(
              () => this.index = newIndex,
            ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  Body(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.display2,
        ),
      ),
    );
  }
}

class TwoItemBottomNavBar extends StatelessWidget {
  TwoItemBottomNavBar({this.index, this.callback});
  final int index;
  final Function(int) callback;

  @override
  Widget build(BuildContext context) {
    /// BottomNavigationBar is automatically set to type 'fixed'
    /// when there are three of less items
    return BottomNavigationBar(
      currentIndex: index,
      onTap: callback,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('First'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Second'),
        ),
      ],
    );
  }
}

class FiveItemBottomNavBar extends StatelessWidget {
  FiveItemBottomNavBar({this.index, this.callback});
  final int index;
  final Function(int) callback;

  @override
  Widget build(BuildContext context) {
    /// BottomNavigationBar is automatically set to type 'shifting'
    /// when there are more than three items. This renders the items in white
    return BottomNavigationBar(
      currentIndex: index,
      onTap: callback,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('First'),
          backgroundColor: Colors.teal,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Second'),
          backgroundColor: Colors.pink,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Third'),
          backgroundColor: Colors.amber,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Fourth'),
          backgroundColor: Colors.indigo,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Fifth'),
          backgroundColor: Colors.lime,
        )
      ],
    );
  }
}
