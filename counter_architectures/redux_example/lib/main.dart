/// Mostly taken from: https://pub.dartlang.org/packages/flutter_redux

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum Actions { increment }

int counterReducer(int state, dynamic action) {
  if (action == Actions.increment) {
    return ++state;
  }
  return state;
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: Store<int>(counterReducer, initialState: 0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              StoreConnector<int, String>(
                converter: (store) => store.state.toString(),
                builder: (context, count) => Text(
                      count,
                      style: Theme.of(context).textTheme.display1,
                    ),
              ),
            ],
          ),
        ),
        floatingActionButton: new StoreConnector<int, VoidCallback>(
          converter: (store) => () => store.dispatch(Actions.increment),
          builder: (context, callback) => FloatingActionButton(
                onPressed: callback,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
        ),
      ),
    );
  }
}
