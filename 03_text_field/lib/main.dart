// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(TextFieldExampleApp());
}

class TextFieldExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multi-Line Text Field Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: const Text('Text Fields'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleLineTextFieldWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiLineTextFieldAndButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Single-line text field widget
class SingleLineTextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: TextField(
        autocorrect: false, // turns off auto-correct
        decoration: InputDecoration(
          hintText: 'Enter text; return submits',
        ),
        onChanged: (str) => print('Single-line text change: $str'),
        onSubmitted: (str) => _showInSnackBar(context, '$str'),
      ),
    );
  }
}

/// Multi-line text field widget with a submit button
class MultiLineTextFieldAndButtonWidget extends StatefulWidget {
  MultiLineTextFieldAndButtonWidget({Key key}) : super(key: key);

  @override
  createState() => _TextFieldAndButtonState();
}

class _TextFieldAndButtonState
    extends State<MultiLineTextFieldAndButtonWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      //color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Enter text; return doesn\'t submit',
            ),
            onChanged: (str) => print('Multi-line text change: $str'),
            onSubmitted: (str) =>
                print('This will not get called when return is pressed'),
          ),
          SizedBox(height: 10.0),
          FlatButton(
            onPressed: () => _showInSnackBar(
                  context,
                  '${_controller.text}',
                ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

/// Displays text in a snackbar
_showInSnackBar(BuildContext context, String text) {
  Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(text),
      ));
}
