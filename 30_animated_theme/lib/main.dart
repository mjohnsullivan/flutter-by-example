// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final themeData1 = ThemeData(
  primarySwatch: Colors.cyan,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.purple,
    textTheme: ButtonTextTheme.primary,
    shape: StadiumBorder(),
  ),
);

final themeData2 = ThemeData(
  primarySwatch: Colors.green,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.lightBlue,
  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedTheme example',
      theme: themeData1,
      home: MyThemedPage(),
    );
  }
}

class MyThemedPage extends StatefulWidget {
  @override
  createState() => _MyThemedPageState();
}

class _MyThemedPageState extends State<MyThemedPage> {
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
    themeData = themeData1;
  }

  void _updateTheme() {
    if (themeData == themeData1)
      print('Theme Data 1');
    else
      print('Theme Data 2');
    setState(
      () => themeData = themeData == themeData1 ? themeData2 : themeData1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      duration: const Duration(milliseconds: 2000),
      curve: ElasticInOutCurve(),
      data: themeData,
      child: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedTheme Example'),
          actions: [
            IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: _updateTheme,
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('I am a button'),
                onPressed: _updateTheme,
              ),
              Text('I am some text'),
            ],
          ),
        ),
      ),
    );
  }
}
