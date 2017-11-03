// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(new NavigationExampleApp());
}

class NavigationExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The MaterialApp's home is automatically set as the bottom of the navigation stack
    return new MaterialApp(
      title: 'Navigation Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('Go to Second'),
          onPressed: () {
            // Pushs the SecondScreen widget onto the navigation stack
            Navigator.of(context).push(new MaterialPageRoute<Null>(
              builder: (BuildContext context) => new SecondScreen()
            ));
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second Screen'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('Go to First'),
          // Pops Second Screen off the navigation stack
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}