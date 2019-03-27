// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class Counter with ChangeNotifier {
  int _value = 0;

  int get value => _value;

  set value(int value) {
    _value = value;
    notifyListeners();
  }

  void increment() {
    _value++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChangeNotifier with Provider',
      home: ChangeNotifierProvider<Counter>(
        notifier: Counter(),
        child: Builder(
          builder: (context) => Scaffold(
              appBar: AppBar(title: Text('ChangeNotifier with Provider')),
              body: CounterHomePage(),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Provider.of<Counter>(context).increment(),
                tooltip: 'Increment',
                child: Icon(Icons.add),
              )),
        ),
      ),
    );
  }
}

class CounterHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Consumer<Counter>(
            builder: (context, counter) => Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.display1,
                ),
          ),
        ],
      ),
    );
  }
}
