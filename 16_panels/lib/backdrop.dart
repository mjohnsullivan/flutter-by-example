// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Adapted from
// https://github.com/flutter/udacity-course/blob/master/unit_converter/unit_converter/lib/backdrop.dart

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

const _kFlingVelocity = 2.0;

class _BackdropPanel extends StatelessWidget {
  const _BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
    this.titleHeight,
    this.padding,
  }) : super(key: key);

  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;
  final double titleHeight;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        elevation: 12.0,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: onVerticalDragUpdate,
              onVerticalDragEnd: onVerticalDragEnd,
              onTap: onTap,
              child: Container(height: titleHeight, child: title),
            ),
            Divider(
              height: 1.0,
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

/// Builds a Backdrop.
///
/// A Backdrop widget has two panels, front and back. The front panel is shown
/// by default, and slides down to show the back panel, from which a user
/// can make a selection. The user can also configure the titles for when the
/// front or back panel is showing.
class Backdrop extends StatefulWidget {
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontHeader;
  final double frontPanelOpenHeight;
  final double frontHeaderHeight;
  final bool frontHeaderVisibleClosed;
  final EdgeInsets frontPanelPadding;
  final ValueNotifier<bool> panelVisible;

  Backdrop(
      {@required this.frontLayer,
      @required this.backLayer,
      this.frontPanelOpenHeight = 0.0,
      this.frontHeaderHeight = 48.0,
      this.frontPanelPadding = const EdgeInsets.all(0.0),
      this.frontHeaderVisibleClosed = true,
      this.panelVisible,
      this.frontHeader})
      : assert(frontLayer != null),
        assert(backLayer != null);

  @override
  createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      // value of 0 hides the panel; value of 1 fully shows the panel
      value: (widget.panelVisible?.value ?? true) ? 1.0 : 0.0,
      vsync: this,
    );

    // Listen on the toggle value notifier if it's not null

    widget.panelVisible?.addListener(_subscribeToValueNotifier);

    // Ensure that the value notifier is updated when the panel is opened or closed
    if (widget.panelVisible != null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed)
          widget.panelVisible.value = true;
        else if (status == AnimationStatus.dismissed)
          widget.panelVisible.value = false;
      });
    }
  }

  void _subscribeToValueNotifier() {
    if (widget.panelVisible.value != _backdropPanelVisible)
      _toggleBackdropPanelVisibility();
  }

  /// Required for resubscribing when hot reload occurs
  @override
  void didUpdateWidget(Backdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.panelVisible?.removeListener(_subscribeToValueNotifier);
    widget.panelVisible?.addListener(_subscribeToValueNotifier);
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.panelVisible?.dispose();
    super.dispose();
  }

  bool get _backdropPanelVisible =>
      _controller.status == AnimationStatus.completed ||
      _controller.status == AnimationStatus.forward;

  void _toggleBackdropPanelVisibility() => _controller.fling(
      velocity: _backdropPanelVisible ? -_kFlingVelocity : _kFlingVelocity);

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_controller.isAnimating)
      _controller.value -= details.primaryDelta / _backdropHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(_kFlingVelocity, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-_kFlingVelocity, -flingVelocity));
    else
      _controller.fling(
          velocity:
              _controller.value < 0.5 ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final panelSize = constraints.biggest;
      final closedPercentage = widget.frontHeaderVisibleClosed
          ? (panelSize.height - widget.frontHeaderHeight) / panelSize.height
          : 1.0;
      final openPercentage = widget.frontPanelOpenHeight / panelSize.height;

      final panelDetailsPosition = Tween<Offset>(
        begin: Offset(0.0, closedPercentage),
        end: Offset(0.0, openPercentage),
      ).animate(_controller.view);

      return Container(
        key: _backdropKey,
        child: Stack(
          children: <Widget>[
            widget.backLayer,
            SlideTransition(
              position: panelDetailsPosition,
              child: _BackdropPanel(
                onTap: _toggleBackdropPanelVisibility,
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                title: widget.frontHeader,
                titleHeight: widget.frontHeaderHeight,
                child: widget.frontLayer,
                padding: widget.frontPanelPadding,
              ),
            ),
          ],
        ),
      );
    });
  }
}
