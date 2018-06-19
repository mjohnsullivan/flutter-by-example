// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'backdrop.dart';

/// tracks what can be displayed in the front panel
enum FrontPanels { tealPanel, limePanel }

/// Tracks which front panel should be displayed
class FrontPanelModel extends Model {
  FrontPanelModel(this._activePanel);
  FrontPanels _activePanel;

  FrontPanels get activePanelType => _activePanel;

  Widget panelTitle(BuildContext context) {
    return Container(
      color: _activePanel == FrontPanels.tealPanel ? Colors.teal : Colors.lime,
      padding: EdgeInsetsDirectional.only(start: 16.0),
      alignment: AlignmentDirectional.centerStart,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: _activePanel == FrontPanels.tealPanel
            ? Text('Teal Panel')
            : Text('Lime Panel'),
      ),
    );
  }

  Widget get activePanel =>
      _activePanel == FrontPanels.tealPanel ? TealPanel() : LimePanel();

  void activate(FrontPanels panel) {
    _activePanel = panel;
    notifyListeners();
  }
}

class ComplexExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScopedModel(
      model: FrontPanelModel(FrontPanels.tealPanel),
      child: Scaffold(body: SafeArea(child: Panels())));
}

class Panels extends StatelessWidget {
  final frontPanelVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FrontPanelModel>(
      builder: (context, _, model) => Backdrop(
            frontLayer: model.activePanel,
            backLayer: BackPanel(
              frontPanelOpen: frontPanelVisible,
            ),
            frontHeader: model.panelTitle(context),
            panelVisible: frontPanelVisible,
            frontPanelOpenHeight: 40.0,
            frontHeaderHeight: 48.0,
          ),
    );
  }
}

class TealPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(color: Colors.teal, child: Center(child: Text('Teal panel')));
}

class LimePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(color: Colors.lime, child: Center(child: Text('Lime panel5')));
}

/// This needs to be a stateful widget in order to display which front panel is open
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
              child: ScopedModelDescendant<FrontPanelModel>(
            rebuildOnChange: false,
            builder: (context, _, model) => RaisedButton(
                  color: Colors.teal,
                  child: Text('show teal panel'),
                  onPressed: () {
                    model.activate(FrontPanels.tealPanel);
                    widget.frontPanelOpen.value = true;
                  },
                ),
          )),
          Center(
              child: ScopedModelDescendant<FrontPanelModel>(
            rebuildOnChange: false,
            builder: (context, _, model) => RaisedButton(
                  color: Colors.lime,
                  child: Text('show lime panel'),
                  onPressed: () {
                    model.activate(FrontPanels.limePanel);
                    widget.frontPanelOpen.value = true;
                  },
                ),
          )),
          Center(
              child: RaisedButton(
            child: Text('show current panel'),
            onPressed: () {
              widget.frontPanelOpen.value = true;
            },
          )),
          // will not be seen; covered by front panel
          Center(child: Text('Bottom of Panel')),
        ]);
  }
}
