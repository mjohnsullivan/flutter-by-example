import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'backdrop.dart';

/// tracks what can be displayed in the front panel
enum FrontPanels { firstPanel, secondPanel }

/// Tracks which front panel should be displayed
class FrontPanelModel extends Model {
  FrontPanelModel(this._activePanel);
  FrontPanels _activePanel;

  FrontPanels get activePanelType => _activePanel;

  Widget get panelTitle {
    switch (_activePanel) {
      case FrontPanels.firstPanel:
        return Text('First Panel');
      case FrontPanels.secondPanel:
        return Text('Second Panel');
      default:
        return Text('Unknown');
    }
  }

  Widget get activePanel {
    switch (_activePanel) {
      case FrontPanels.firstPanel:
        return FrontPanel1();
      case FrontPanels.secondPanel:
        return FrontPanel2();
      default:
        return FrontPanel1();
    }
  }

  void activate(FrontPanels panel) {
    _activePanel = panel;
    notifyListeners();
  }
}

class ComplexExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScopedModel(
      model: FrontPanelModel(FrontPanels.firstPanel),
      child: Scaffold(body: SafeArea(child: Panels())));
}

class Panels extends StatelessWidget {
  final frontPanelVisible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FrontPanelModel>(
      builder: (context, _, model) => Backdrop(
            frontPanel: model.activePanel,
            backPanel: BackPanel(
              frontPanelOpen: frontPanelVisible,
            ),
            frontHeader: model.panelTitle,
            panelVisible: frontPanelVisible,
            backPanelHeight: 40.0,
            frontPanelClosedHeight: 48.0,
          ),
    );
  }
}

class FrontPanel1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,
        child: Center(child: Text('First panel')));
  }
}

class FrontPanel2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,
        child: Center(child: Text('Second panel')));
  }
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
              child: ScopedModelDescendant<FrontPanelModel>(
            builder: (context, _, model) => FlatButton(
                  child: Text('show first panel'),
                  onPressed: () {
                    model.activate(FrontPanels.firstPanel);
                    widget.frontPanelOpen.value = true;
                  },
                ),
          )),
          Center(
              child: ScopedModelDescendant<FrontPanelModel>(
            builder: (context, _, model) => FlatButton(
                  child: Text('show second panel'),
                  onPressed: () {
                    model.activate(FrontPanels.secondPanel);
                    widget.frontPanelOpen.value = true;
                  },
                ),
          )),
          Center(
              child: FlatButton(
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
