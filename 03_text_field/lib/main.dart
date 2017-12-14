// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(new TextFieldExampleApp());
}

class TextFieldExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Multi-Line Text Field Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Multi-Line Text Field'),
        ),
        body: new Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SingleLineTextFieldWidget(),
            new MultiLineTextFieldAndButtonWidget(), 
          ],
        ),
      ),
    );
  }
}

/// Single-line text field widget
class SingleLineTextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext content) {
    return new TextField(
      autocorrect: false, // turns off auto-correct
      decoration: new InputDecoration(
        hintText: 'Enter text; return submits',
      ),
      onChanged: (str) => print('Single-line text change: $str'),
      onSubmitted: (str) => print('Single-line submitted: $str'),
    );
  }
}

/// Multi-line text field widget with a submit button
class MultiLineTextFieldAndButtonWidget extends StatefulWidget {
  MultiLineTextFieldAndButtonWidget({Key key}) : super(key: key);

  @override
  _TextFieldAndButtonState createState() => new _TextFieldAndButtonState();
}

class _TextFieldAndButtonState extends State<MultiLineTextFieldAndButtonWidget> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TextField(
          controller: _controller,
          maxLines: 10,
          decoration: new InputDecoration(
            hintText: 'Enter text; return doesn\'t submit',
          ),
          onChanged: (str) => print('Multi-line text change: $str'),
          onSubmitted: (str) => print('This will not get called when return is pressed'),
        ),
        new RaisedButton(
          onPressed: () => print('Multi-line submitted: ${_controller.text}'),
          child: new Text('Submit'),
        ),
      ],
    );
  }
}