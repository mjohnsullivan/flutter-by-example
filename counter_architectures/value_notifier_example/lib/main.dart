/// Based on https://medium.com/@maksimrv/reactive-app-state-in-flutter-73f829bcf6a7
/// and https://gist.github.com/c88f116d7d65d7222ca673b5f9c5bcc3

import 'package:flutter/material.dart';
import 'provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap the widget tree in a Provider
    return new Provider(
      // Set the initial state of the counter
      initialValue: 0,
      child: new MaterialApp(
        title: 'InhertiedWidget with ValueNotifier Example',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(title: 'IW with VN Example'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    // Pull the counter value from the Provider
    final _counter = Provider.of(context).value;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _incrementCounter(context),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  // Increment the counter via the Provider
  _incrementCounter(context) => Provider.of(context).value += 1;
}
