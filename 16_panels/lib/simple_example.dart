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
      frontPanel: FrontPanel(),
      backPanel: BackPanel(
        frontPanelOpen: frontPanelVisible,
      ),
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
    widget.frontPanelOpen.addListener(
        () => setState(() => panelOpen = widget.frontPanelOpen.value));
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
              child: FlatButton(
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
