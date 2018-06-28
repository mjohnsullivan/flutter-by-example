// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'backdrop.dart';

class SimpleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: SafeArea(child: Panels()));
}

class Panels extends StatelessWidget {
  final frontPanelVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      frontLayer: FrontPanel(),
      backLayer: BackPanel(
        frontPanelOpen: frontPanelVisible,
      ),
      frontHeader: FrontPanelTitle(),
      panelVisible: frontPanelVisible,
      frontPanelOpenHeight: 40.0,
      frontHeaderHeight: 48.0,
      frontHeaderVisibleClosed: true,
    );
  }
}

class FrontPanelTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: Text(
        'Tap Me',
        style: Theme.of(context).textTheme.subhead,
      ),
    );
  }
}

class FrontPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,
        child: Center(child: Text('Hello world')));
  }
}

class BackPanel extends StatefulWidget {
  BackPanel({@required this.frontPanelOpen});
  final ValueNotifier<bool> frontPanelOpen;

  @override
  createState() => _BackPanelState();
}

class _BackPanelState extends State<BackPanel> {
  bool panelOpen;

  @override
  initState() {
    super.initState();
    panelOpen = widget.frontPanelOpen.value;
    widget.frontPanelOpen.addListener(_subscribeToValueNotifier);
  }

  void _subscribeToValueNotifier() =>
      setState(() => panelOpen = widget.frontPanelOpen.value);

  /// Required for resubscribing when hot reload occurs
  @override
  void didUpdateWidget(BackPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.frontPanelOpen.removeListener(_subscribeToValueNotifier);
    widget.frontPanelOpen.addListener(_subscribeToValueNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Text('Front panel is ${panelOpen ? "open" : "closed"}'),
          )),
          Center(
              child: RaisedButton(
            child: Text('Tap Me'),
            onPressed: () {
              widget.frontPanelOpen.value = true;
            },
          )),
          // will not be seen; covered by front panel
          Center(child: Text('Bottom of Panel')),
        ]);
  }
}
