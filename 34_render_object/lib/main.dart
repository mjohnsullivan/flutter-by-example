// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(
    Bottom(
      child: RichText(
        text: TextSpan(
          text: '你好，世界',
          style: TextStyle(
            fontSize: 48,
            color: Color(0xFFFFFFFF),
          ),
        ),
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}

/// A typical way for creating layout widgets; use
/// StatelessWidget and the framework layout widgets
class BottomAsYouShouldWriteIt extends StatelessWidget {
  BottomAsYouShouldWriteIt({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: child,
      );
}

/// Dropping down a layer, we can create a new RenderObjectWidget
/// to achieve the same effect. This is how Flutter has implemented
/// the Center widget via the Align widget.
///
/// Here we're using a SingleChildRenderObject, which is
/// appropriate for layout widgets wrapping a single child.
///
/// A RenderPositionedBox is a RenderObject that lets us position
/// RenderObjects within a Cartesian coordinate system. This
/// RenderObject has an alignment property, where we can specify
/// the position of its children.
class Bottom extends SingleChildRenderObjectWidget {
  const Bottom({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  ///
  @override
  RenderPositionedBox createRenderObject(BuildContext context) =>
      RenderPositionedBox(
        alignment: Alignment.bottomCenter,
        textDirection: Directionality.of(context),
      );
}
