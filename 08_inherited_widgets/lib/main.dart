// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
      title: 'Inherited Widgets Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Inherited Widget Example'),
          ),
          body: new NamePage())));
}

// Inherited widget for managing a name
class NameInheritedWidget extends InheritedWidget {
  const NameInheritedWidget({
    Key key,
    this.name,
    Widget child}) : super(key: key, child: child);

  final String name;

  @override
  bool updateShouldNotify(NameInheritedWidget old) {
    print('In updateShouldNotify');
    return name != old.name;
  }

  static NameInheritedWidget of(BuildContext context) {
    // You could also just directly return the name here
    // as there's only one field
    return context.inheritFromWidgetOfExactType(NameInheritedWidget);
  }
}

// Stateful widget for managing name data
class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => new _NamePageState();
}

// State for managing fetching name data over HTTP
class _NamePageState extends State<NamePage> {
  String name = 'Placeholder';

  // Fetch a name asynchonously over HTTP
  _get() async {
    var res = await http.get('https://jsonplaceholder.typicode.com/users');
    var name = JSON.decode(res.body)[0]['name'];
    setState(() => this.name = name);
  }

  @override
  void initState() {
    super.initState();
    _get();
  }

  @override
  Widget build(BuildContext context) {
    return new NameInheritedWidget(
      name: name,
      child: const IntermediateWidget()
    );
  }
}

// Intermediate widget to show how inherited widgets
// can propagate changes down the widget tree
class IntermediateWidget extends StatelessWidget {
  // Using a const constructor makes the widget cacheable
  const IntermediateWidget();

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: const NameWidget()));
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget();

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = NameInheritedWidget.of(context);
    return new Text(
      inheritedWidget.name,
      style: Theme.of(context).textTheme.display1,
    );
  }
}
