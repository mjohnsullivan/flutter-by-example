import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

final colors = {'yellow': 0xFFFFFF00, 'blue': 0xFF0000FF, 'green': 0xFF00FF00};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Color(0xFFFFFFFF),
      builder: (context, _) => GridPage(),
    );
  }
}

// Display is represented by a list of 16 bit ints
// where each int is one row on the screen
final display = <int>[16];

class GridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: DesignGrid(),
      ),
    );
  }
}

class DesignGrid extends StatefulWidget {
  final dimension = 16;

  @override
  createState() => _DesignGridState();
}

class _DesignGridState extends State<DesignGrid> {
  List<bool> pixels;

  @override
  void initState() {
    pixels =
        List<bool>.generate(widget.dimension * widget.dimension, (j) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 16,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      children: pixels
          .map((pixel) => Container(
              color: pixel ? Color(colors['yellow']) : Color(colors['blue'])))
          .toList(),
    );
  }
}
