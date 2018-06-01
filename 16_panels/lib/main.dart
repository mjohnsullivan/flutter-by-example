// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:panels/backdrop.dart';
import 'package:panels/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: panelTheme,
        title: 'Panels Demo',
        home: MyHomePage(),
      );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: SafeArea(child: Panels()));
}

class Panels extends StatelessWidget {
  final frontPanelVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      frontPanel: FrontPanel(),
      backPanel: BackPanel(
        toggleFrontPanel: frontPanelVisible,
      ),
      frontTitle: Text('Front Panel'),
      backTitle: Text('Back Panel'),
      frontHeader: Text('Give me a tap'),
      panelVisible: frontPanelVisible,
      backPanelHeight: 40.0,
      frontPanelClosedHeight: 48.0,
    );
  }
}

class FrontPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Hello world'));
  }
}

class BackPanel extends StatelessWidget {
  BackPanel({@required this.toggleFrontPanel});
  final ValueNotifier<bool> toggleFrontPanel;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text('Top of Panel')),
          Center(
              child: FlatButton(
            child: Text('Tap Me'),
            onPressed: () {
              print('Toggling value: ${toggleFrontPanel.value}');
              toggleFrontPanel.value = true;
            },
          )),
          // will not be seen; covered by front panel
          Center(child: Text('Bottom of Panel')),
        ]);
  }
}
