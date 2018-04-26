import 'dart:math';

import 'package:flutter/widgets.dart';

class LinePatterns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      painter: new LinesPatternsPainter(),
    );
  }
}

class LinesPatternsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = new Color(0xFF6666FF)
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = 1.0;
    drawBezierPattern(canvas, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

void drawPatternGrid(Canvas canvas, Paint paint) {
  for (var x = -50.0; x <= 50.0; x += 10.0) {
    canvas.drawLine(new Offset(x, -50.0), new Offset(x, 50.0), paint);
  }
  for (var y = -50.0; y <= 50.0; y += 10.0) {
    canvas.drawLine(new Offset(-50.0, y), new Offset(50.0, y), paint);
  }
}

void drawPatternTest(Canvas canvas, Paint paint) {
  for (var i = -50.0; i <= 50.0; i += 10.0) {
    canvas.drawLine(new Offset(i, -50.0), new Offset(50.0, 50.0), paint);
  }
  for (var i = -50.0; i <= 50.0; i += 10.0) {
    canvas.drawLine(new Offset(50.0, i), new Offset(-50.0, -50.0), paint);
  }
}

void drawPattern(Canvas canvas, Paint paint) {
  for (var i = 0.0; i <= 100.0; i += 5.0) {
    canvas.drawLine(_translate(new Offset(0.0, i), 0.0),
        _translate(new Offset(100 - i, 0.0), 0.0), paint);
  }
  for (var i = 0.0; i <= 100.0; i += 5.0) {
    canvas.drawLine(_translate(new Offset(100.0, i), 0.0),
        _translate(new Offset(100.0 - i, 100.0), 0.0), paint);
  }
}

void drawBezierPattern(Canvas canvas, Paint paint) {
  canvas.drawArc(
      new Rect.fromCircle(center: new Offset(50.0, 50.0), radius: 50.0),
      0.0,
      PI * 2.0,
      true,
      paint);

  Path path = new Path();
  final size = new Size(100.0, 100.0);
  path.lineTo(0.0, size.height - 20);

  var firstControlPoint = new Offset(size.width / 4, size.height);
  var firstEndPoint = new Offset(size.width / 2.25, size.height - 30.0);
  path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
      firstEndPoint.dx, firstEndPoint.dy);

  var secondControlPoint =
      new Offset(size.width - (size.width / 3.25), size.height - 65);
  var secondEndPoint = new Offset(size.width, size.height - 40);
  path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
      secondEndPoint.dx, secondEndPoint.dy);

  path.lineTo(size.width, size.height - 40);
  path.lineTo(size.width, 0.0);

  canvas.drawPath(path, paint);
}

// Translate an offset by a given amount
Offset _translate(Offset offset, double translation) {
  return new Offset(offset.dx - translation, offset.dy - translation);
}
