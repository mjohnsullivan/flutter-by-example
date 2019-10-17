import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ColorFiltered Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            DiscoDash(), /*ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.orange, BlendMode.hue),
          child: Material(
            child: ColumnOfStuff(), // Center(child: DashImage()),
          ),
        ),*/
      ),
    );
  }
}

class TestingColumn extends StatelessWidget {
  const TestingColumn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Center(
              child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.white,
              BlendMode.modulate,
            ),
            child: Icon(
              Icons.send,
              size: 200,
              color: Colors.blue,
            ),
          )),
        ),
        Flexible(
          flex: 1,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.green,
              // screen, hue, modulate
              BlendMode.modulate,
            ),
            child: DiscoDash(),
          ),
        ),
      ],
    );
  }
}

class ColorText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.yellow[200],
        BlendMode.modulate,
      ),
      child: Text('Chameleon words'),
    );
  }
}

class DiscoDash extends StatefulWidget {
  @override
  _DiscoDashState createState() => _DiscoDashState();
}

class _DiscoDashState extends State<DiscoDash> {
  final _colors = [
    Colors.teal,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.yellow,
  ];
  var _beginColorIndex = 0;
  var _endColorIndex = 1;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: ColorTween(
        begin: _colors[_beginColorIndex],
        end: _colors[_endColorIndex],
      ),
      duration: const Duration(seconds: 1),
      curve: Curves.slowMiddle,
      onEnd: () => setState(() {
        _beginColorIndex = _endColorIndex;
        _endColorIndex = (_endColorIndex + 1) % _colors.length;
      }),
      builder: (context, color, _) => ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.hue),
        child: Material(child: ColumnOfStuff()),
      ),
    );
  }
}

class DashImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Image.asset('assets/dash.png');
}

class ColumnOfStuff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tweet Tweet',
          style: TextStyle(color: Colors.blue, fontSize: 48),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        DashImage(),
        SizedBox(height: 10),
        Text(
          'tweet tweet tweet tweet tweet tweet tweet tweet',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue, fontSize: 24),
        ),
        SizedBox(height: 10),
        RaisedButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tweet',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 10),
              Icon(Icons.touch_app, color: Colors.white),
            ],
          ),
          color: Colors.blue,
          onPressed: () {},
        ),
      ],
    );
  }
}
