// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(new NavigationExampleApp());
}

class NavigationExampleApp extends StatelessWidget {

// Adapted from the stocks example:
// https://github.com/flutter/flutter/blob/master/examples/stocks/lib/main.dart
Route<dynamic> _parseRoute(RouteSettings settings) {
    // Split up the path
    final List<String> path = settings.name.split('/');
    // First entry should be empty as all paths should start with a '/'
    assert(path[0] == '');
    // Only valid path is '/second/<double value>'
    if (path[1] == 'second' && path.length == 3) {
      final value = double.parse(path[2]);

      return new MaterialPageRoute<double>(
        settings: settings,
        builder: (BuildContext context) => new SecondScreenWidget(value: value),
      );
    }
    // The other paths we support are in the routes table.
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // The MaterialApp's home is automatically set as the bottom of the navigation stack
    return new MaterialApp(
      title: 'Navigation Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FirstScreenWidget(),
      // Manually parse routes requested through pushNamed() calls
      onGenerateRoute: _parseRoute,
    );
  }
}

class FirstScreenWidget extends StatefulWidget {
  @override
  FirstScreenState createState() => new FirstScreenState();
}

class FirstScreenState extends State<FirstScreenWidget> {
  var _value = 50.0;

  _navigateUsingConstructor() async {
    // Passing data to the second page via the widget's constructor
    // This way of doing things ignores the routing set up in the Material app
    // so you don't need any of that configuration.
    // This is a good way of passing Dart objects through routing
    _value = await Navigator.of(context).push(
      // await is used here to get the returned value from the second screen
      new MaterialPageRoute(
        builder: (context) => new SecondScreenWidget(value: _value)
      )
    ) ?? 1.0; // Back arrow provided by the MaterialApp will not pass back a value
  }

  _navigateUsingRoute() async {
    // Pass the data through the route paths parsed by onGenerateRoute in
    // the Material app
    // This is a good way of passing multiple basic types through routing
    _value = await Navigator.of(context).pushNamed('/second/$_value') ?? 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('First Screen'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            new Slider(
              min: 1.0,
              max: 100.0,
              value: _value,
              onChanged: (value) => setState(() => _value = value),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                  new RaisedButton(
                  child: const Text('Pass via constructor'),
                  onPressed: () {
                    _navigateUsingConstructor();
                  },
                ),
                new RaisedButton(child: const Text('Pass via route'),
                  onPressed: () {
                    _navigateUsingRoute();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreenWidget extends StatefulWidget {
  SecondScreenWidget({this.value: 1.0});
  
  final double value;

  @override
  SecondScreenState createState() => new SecondScreenState(value);
}

class SecondScreenState extends State<SecondScreenWidget> {
  SecondScreenState(this._value);
  double _value;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Second Screen'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            new Slider(
              min: 1.0,
              max: 100.0,
              value: _value,
              onChanged: (value) => setState(() => _value = value),
            ),
            new RaisedButton(
              child: const Text('Return to First'),
                // Pass the value to the new screen
                onPressed: () => Navigator.of(context).pop(_value),
            ),
          ],
        ),
      ),
    );
  }
}