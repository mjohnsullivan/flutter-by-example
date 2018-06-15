// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class IncrementValueModel extends Model {
  IncrementValueModel(this._incrementValue) : super();
  int _incrementValue;
  int _counter = 0;

  int get incrementValue => _incrementValue;
  int get counter => _counter;

  void updateIncrementValue(int value) {
    _incrementValue = value;
    notifyListeners();
  }

  void increment() {
    _counter += _incrementValue;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScopedModel(
          model: IncrementValueModel(1),
          child: MyHomePage(title: 'ModalRoute Demo')),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            ScopedModelDescendant<IncrementValueModel>(
              builder: (context, _, model) => Text(
                    '${model.counter}',
                    style: Theme.of(context).textTheme.display1,
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: ScopedModelDescendant<IncrementValueModel>(
        rebuildOnChange: false,
        builder: (context, _, model) => FloatingActionButton(
              onPressed: model.increment,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IncrementValueModel>(
      builder: (context, _, model) => BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: IconButton(
                  icon: Icon(Icons.settings,
                      color: Theme.of(context).canvasColor),
                  onPressed: () => _modalBottomSheet(context, model),
                ),
              ),
            ],
          )),
    );
  }
}

/// The model must be passed in, as ScopedModel doesn't span a ModalBottomSheet
void _modalBottomSheet(BuildContext context, IncrementValueModel model) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return ScopedModel(model: model, child: CustomBottomSheet());
      });
}

class CustomBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 25.0),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Increment Value',
                    style: Theme.of(context).textTheme.body1),
                CustomSlider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<IncrementValueModel>(
        builder: (context, _, model) {
      return Row(
        children: [
          Expanded(
            child: Slider(
              value: model.incrementValue.toDouble(),
              min: 1.0,
              max: 10.0,
              label: 'Increment Step',
              onChanged: (double value) =>
                  model.updateIncrementValue(value.toInt()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child:
                Container(width: 30.0, child: Text('${model.incrementValue}')),
          ),
        ],
      );
    });
  }
}
