// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Bottom Sheet Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  PersistentBottomSheetController _controller;
  bool _isSheetOpen = false;

  _updateButtonState() async {
    if (_isSheetOpen) {
      setState(() => _isSheetOpen = false);
      _controller.close();
    } else {
      setState(() => _isSheetOpen = true);
      // If the sheet is now open, make sure to update
      // the button is the sheet is closed by other means
      await _controller.closed;
      setState(() => _isSheetOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text(_isSheetOpen
              ? 'Close the bottom sheet'
              : 'Open the bottom sheet'),
          onPressed: () {
            // If there's no bottom sheet, create a new one
            if (!_isSheetOpen) _controller = _showBottomSheet(context);
            _updateButtonState();
          }),
    );
  }
}

PersistentBottomSheetController _showBottomSheet(BuildContext context) {
  return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('I will persist until you close me',
                    style: Theme
                        .of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white)),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.white),
                )
              ],
            ),
          ),
        );
      });
}
