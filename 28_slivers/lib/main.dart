import 'package:flutter/material.dart';

void main() => runApp(MySliverApp());

class MySliverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slivers Demo',
      home: MySliverPage(),
    );
  }
}

class MySliverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Slivers go here ...')),
    );
  }
}
