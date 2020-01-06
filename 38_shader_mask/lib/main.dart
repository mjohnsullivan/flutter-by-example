import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shader Masks',
      home: Scaffold(
        appBar: AppBar(title: const Text('Shader Masks')),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            // Fire text
            child: ShaderMask(
              shaderCallback: (bounds) => RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: [Colors.yellow, Colors.deepOrange.shade900],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: const Text('Flame on!',
                  style: TextStyle(fontSize: 50, color: Colors.white)),
            ),
          ),
          Flexible(
            flex: 1,
            // Recolor a widget
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.grey, Colors.grey],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: const FlutterLogo(size: 100),
            ),
          ),
          Flexible(
            flex: 1,
            // Fading widgets
            child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const [
                        Color(0xFFFFFFFF),
                        Color(0x33FFFFFF),
                        Color(0x00FFFFFF),
                      ],
                    ).createShader(bounds),
                child: const FlutterLogo(size: 100)),
          ),
        ],
      ),
    );
  }
}
