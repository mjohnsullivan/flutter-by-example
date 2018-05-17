import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const Scaffold(
            body: SafeArea(
      child: TabbedPages(
        tabs: [
          Center(child: Text('First Tab')),
          Center(child: FlutterLogo(size: 200.0)),
          Center(child: Icon(Icons.ac_unit, size: 200.0)),
        ],
      ),
    )));
  }
}

class TabbedPages extends StatefulWidget {
  const TabbedPages({this.tabs});
  final List<Widget> tabs;

  @override
  createState() => _TabbedPagesState();
}

class _TabbedPagesState extends State<TabbedPages>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.tabs.length, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TabBar is optional, trying commenting it out
        TabBar(
          tabs: [
            const Text('First Tab', style: TextStyle(color: Colors.black)),
            const Text('Second Tab', style: TextStyle(color: Colors.black)),
            const Text('Third Tab', style: TextStyle(color: Colors.black))
          ],
          controller: _controller,
        ),
        Expanded(
          child: TabBarView(
            children: widget.tabs,
            controller: _controller,
          ),
        ),
        // These controls could also be optional; try commenting them out
        Row(children: [
          FlatButton(
              child: Row(
                children: [
                  const Icon(Icons.chevron_left),
                  const Text('BACK'),
                ],
              ),
              onPressed: _controller.index > 0
                  ? () => _controller.animateTo(_controller.index - 1)
                  : null),
          Expanded(
            child: Center(
              child: TabPageSelector(
                controller: _controller,
                indicatorSize: 10.0,
              ),
            ),
          ),
          FlatButton(
              child: Row(
                children: [
                  const Text('NEXT'),
                  const Icon(Icons.chevron_right),
                ],
              ),
              onPressed: _controller.index < _controller.length - 1
                  ? () => _controller.animateTo(_controller.index + 1)
                  : null),
        ]),
      ],
    );
  }
}
