import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Filter Demo',
      home: Scaffold(body: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blurFilter = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(color: Colors.black.withOpacity(0)),
    );

    final matrixFilter = BackdropFilter(
        filter: ImageFilter.matrix(Matrix4.skew(0.5, 0.0).storage),
        //ImageFilter.matrix(Matrix4.diagonal3(v.Vector3(2, 0, 1)).storage),
        child: Container(
          color: Colors.black.withOpacity(0.0),
        ));

    final image = FadeInImage.memoryNetwork(
      fit: BoxFit.fill,
      placeholder: Uint8List(0),
      image: 'https://flutter.io/images/catalog-widget-placeholder.png',
    );

    final stretchedImage = Row(
      children: [Expanded(child: image)],
    );

    final logo = FlutterLogo(size: 50);

    final blurredImage = Stack(
      children: [
        stretchedImage,
        Positioned.fill(child: blurFilter),
      ],
    );

    final partiallyBlurredImage = Stack(
      children: [
        stretchedImage,
        Positioned(
          top: 150,
          bottom: 10,
          left: 10,
          right: 10,
          child: blurFilter,
        ),
      ],
    );

    final transformedImage = Stack(
      children: [
        stretchedImage,
        Positioned.fill(child: matrixFilter),
      ],
    );

    return Center(child: blurredImage);
  }
}
