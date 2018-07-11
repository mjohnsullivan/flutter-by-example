// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Detection',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scrolling Detection'),
        ),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String scrollingMessage = 'I am a scroll detector';

  bool _scrollingStarted() {
    setState(() => scrollingMessage = 'Wheeeeeeee!');
    return false;
  }

  bool _scrollingEnded() {
    setState(() => scrollingMessage = 'Snore ...');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(scrollingMessage),
      ),
      NotificationListener<ScrollStartNotification>(
        onNotification: (_) => _scrollingStarted(),
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (_) => _scrollingEnded(),
          child: Expanded(
            child: ListView(
                children: List<ListTile>.generate(
              100,
              (i) => ListTile(title: Text('$i')),
            )),
          ),
        ),
      ),
    ]);
  }
}
