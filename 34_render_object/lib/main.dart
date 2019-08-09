import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(
      Bottom(
        child: RichText(
          text: TextSpan(
            text: 'Hello World',
            style: TextStyle(
              fontSize: 48,
              color: Color(0xFFFFFFFF),
            ),
          ),
          textDirection: TextDirection.ltr,
        ),
      ),
    );

/// Here we're using a SingleChildRenderObject, which is
/// appropriate for layout widgets wrapping a single child
class Bottom extends SingleChildRenderObjectWidget {
  const Bottom({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  RenderPositionedBox createRenderObject(BuildContext context) =>
      RenderPositionedBox(
        alignment: Alignment.bottomCenter,
        widthFactor: 1,
        heightFactor: 1,
        textDirection: Directionality.of(context),
      );

  @override
  void updateRenderObject(
          BuildContext context, RenderPositionedBox renderObject) =>
      renderObject.textDirection = Directionality.of(context);
}
