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
          home: new StackExamplePage(),
        );
      }
    }

    class StackExamplePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return new Scaffold(
            backgroundColor: Colors.grey,
            appBar: new AppBar(
                title: new Text('Stack Example')
            ),
            body: _createStack()
        );
      }

      _createStack() {
        return new Stack(
            children: <Widget>[
              new Image.network(
                'https://i.imgur.com/FsXL8vI.jpg',
              ),
              // Black square centered in stack
              new Align(
                alignment: new Alignment(0.0, 0.0),
                child: new Container(
                  height: 50.0,
                  width: 50.0,
                  child: new DecoratedBox(
                    decoration: new BoxDecoration(
                        color: Colors.black
                    ),
                  ),
                ),
              ),
              new Align(
                // alignment: Alignment.topLeft,
                alignment: const Alignment(-1.0, -1.0),
                child: new Text('Top Left',
                    style: new TextStyle(color: Colors.yellow)),
              ),
              new Align(
                // alignment: Alignment.bottomRight,
                alignment: const Alignment(1.0, 1.0),
                child: new Text('Bottom Right',
                    style: new TextStyle(color: Colors.yellow)),
              ),
              new Align(
                alignment: new Alignment(-0.8, -0.8),
                child: new Text(
                    '10% in', style: new TextStyle(color: Colors.yellow)),
              ),
              new Align(
                alignment: new Alignment(0.8, 0.8),
                child: new Text(
                    '90% in', style: new TextStyle(color: Colors.yellow)),
              ),
            ]
        );
      }
    }
