import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Add 2 App Demo',
      home: MyFragmentPage(),
    );
  }
}

class MyFragmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('I am a Flutter Fragment!!!'),
    ));
  }
}
