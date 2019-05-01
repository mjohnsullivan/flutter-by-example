import 'dart:math';

import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

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
        child: MyGrid(),
      ),
    );
  }
}

class MyGrid extends StatelessWidget {
  List<Widget> _generatePixelBuffer() {
    final word = Random.secure().nextInt(0xFFFF);
    final pixels = <Widget>[];

    for (var i = 15; i >= 0; i--) {
      if ((word >> i) & 0x1 == 0x1) {
        pixels.add(Container(color: Color(0xFFFFFF00)));
      } else {
        pixels.add(Container(color: Color(0x00000000)));
      }
    }
    return pixels;
  }

  @override
  Widget build(BuildContext context) {
    final screenBuffer = <Widget>[];
    for (int i = 0; i < 16; i++) {
      screenBuffer.addAll(_generatePixelBuffer());
    }
    return GridView.count(
      crossAxisCount: 16,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      children: screenBuffer,
    );
  }
}

class DisplayRowAsText extends StatelessWidget {
  final int bits;
  DisplayRowAsText(this.bits);

  @override
  Widget build(BuildContext context) {
    final output = StringBuffer('$bits  == ');
    for (var i = 15; i >= 0; i--) {
      if ((bits >> i) & 0x1 == 0x1) {
        output.write('1');
      } else {
        output.write('0');
      }
    }
    return Text(output.toString());
  }
}
