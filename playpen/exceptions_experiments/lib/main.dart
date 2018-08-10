import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureText(),
          SizedBox(height: 20.0),
          StreamText(),
        ],
      ),
    ));
  }
}

class FutureText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureExceptionThrower(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // return Text('Something bad happened to future');
              return Text(snapshot.error.toString());
            }
            return Text(snapshot.data, style: TextStyle(fontSize: 25.0));
          }
          return CircularProgressIndicator();
        });
  }
}

class StreamText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: intermediateStream(streamExceptionThrower()),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Text('Something bad happened to stream');
            }
            return Text(snapshot.data);
          }
          return CircularProgressIndicator();
        });
  }
}

Future<String> futureExceptionThrower() async {
  String res = await Future.delayed(Duration(seconds: 2), () {
    throw Exception('future boom!!');
    return 'I am a string';
  });
  return res;
}

Stream<int> streamExceptionThrower() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    if (i >= 3) {
      throw Exception('stream boom');
    }
    return i;
  });
}

Stream<String> intermediateStream(Stream<int> incomingStream) {
  final c = StreamController<String>();
  final sub = incomingStream.listen((i) => c.add('$i'));
  //sub.onError((e) {
  //  print('INTERMEDIATE STREAM: $e');
  //  c.addError(e);
  //});
  return c.stream;
}
