// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

void main() => runApp(MyApp());

final yellow = Color(0xFFFFFF00);

final textStyle = TextStyle(
  color: yellow,
  fontSize: 24,
);

final crawlString1 = """
Lorem ipsum dolor sit amet, in sea illud veritus suavitate, mutat ullum ut pro. Fabulas accusata cu ius, nec an quem vituperatoribus, ex mel doctus splendide. Eam habeo fabellas ne, principes reprimique sea ad. Et vim scaevola accommodare. Vim ad eius adhuc homero. Maiestatis elaboraret ei nam.

An usu fugit recteque ullamcorper, ea eos essent molestiae reprimique. Vocibus instructior ne nec. Justo reprehendunt ut has, vel ea clita signiferumque. Sale disputationi ut quo.
""";
final crawlString2 = """
\nCum nibh assentior tincidunt ad. Mei te accusam convenire partiendo, facilisi expetenda inciderint ei has. Falli corrumpit an per, no vis vidisse accusata, nibh noster dolores sea ex. Singulis accusamus at cum, tation aliquip mediocritatem duo et. Ei mel suas argumentum, pri no purto ignota quaerendum.
""";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Color(0xFF000000),
      builder: (context, _) => CrawlPage(),
    );
  }
}

class CrawlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Flexible(
        flex: 5,
        child: Perspective(child: Crawler()),
      ),
      Flexible(
        flex: 1,
        child: Column(),
      ),
    ]);
  }
}

class Crawler extends StatefulWidget {
  final crawlDuration = const Duration(seconds: 20);

  @override
  createState() => _CrawlerState();
}

class _CrawlerState extends State<Crawler> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 500),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: widget.crawlDuration,
            curve: Curves.linear));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SuperSize(
      height: 1279,
      child: ListView(
        controller: _scrollController,
        children: [
          SizedBox(height: height),
          Text(
            crawlString1,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          FlutterLogo(size: width / 1.5),
          Text(
            crawlString2,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: height),
        ],
      ),
    );
  }
}

class SuperSize extends StatelessWidget {
  SuperSize({this.child, this.height = 1000});
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minHeight: height,
      maxHeight: height,
      child: child,
    );
  }
}

class Perspective extends StatelessWidget {
  Perspective({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(-3.14 / 3.5),
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}
