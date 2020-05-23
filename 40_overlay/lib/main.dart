import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Overlay Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OverlayEntry overlayEntry;
  bool _overlayVisible = false;

  @override
  void initState() {
    super.initState();
    overlayEntry = OverlayEntry(
      builder: (context) => OverLayExample(),
    );
  }

  void _showOverlay(BuildContext context) {
    // If you want to show the overlay before build() occurs, for example in
    // initState, use WidgetsBinding.instance.addPostFrameCallback() to ensure
    // the overlay is added after build is complete
    final overlay = Overlay.of(context);
    overlay.insert(overlayEntry);
  }

  void _hideOverlay() => overlayEntry.remove();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Example'),
      ),
      body: Center(
        child: FlatButton(
          child: Text(
            _overlayVisible ? 'Hide Overlay' : 'Show Overlay',
          ),
          onPressed: () => setState(() {
            if (_overlayVisible) {
              _hideOverlay();
              _overlayVisible = false;
            } else {
              _showOverlay(context);
              _overlayVisible = true;
            }
          }),
        ),
      ),
    );
  }
}

class OverLayExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 100, left: 100),
        child: Text(
          'I am an overlay',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
