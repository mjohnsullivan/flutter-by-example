// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          GrainyLogo(),
        ],
      ),
    );
  }
}

class GrainyLogo extends StatefulWidget {
  @override
  _GrainyLogoState createState() => _GrainyLogoState();
}

class _GrainyLogoState extends State<GrainyLogo> {
  Future<ui.Image> rawImage;

  @override
  void initState() {
    super.initState();
    rawImage = _loadImage();
  }

  /// Loads a raw image from assets
  Future<ui.Image> _loadImage() async {
    final imageBytes = await rootBundle.load('assets/texture.png');
    return decodeImageFromList(imageBytes.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    var matrix = Matrix4.identity();
    matrix.scale(0.1, 0.1, 0.1);

    return FutureBuilder(
        future: rawImage,
        builder: (context, AsyncSnapshot<ui.Image> image) {
          return (image.hasData)
              ? ShaderMask(
                  shaderCallback: (bounds) => ImageShader(
                        image.data,
                        TileMode.mirror,
                        TileMode.mirror,
                        matrix.storage,
                      ),
                  blendMode: BlendMode.srcATop,
                  child: const FlutterLogo(size: 100))
              : Container();
        });
  }
}
