import 'package:flutter/material.dart';

class WavyPic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: CoffeePic(),
      //child: Container(height: 100.0, color: Color(0x88888888)),
      clipper: BottomWaveClipper(),
    );
  }
}

class CoffeePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Image.network(
        'https://cdn-mf0.heartyhosting.com/sites/mensfitness.com/files/styles/wide_videos/public/coffee_main_0.jpg');
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

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

    /*
    // Draw a straight line from current point to the bottom left corner.
    // Path starts at (0,0) by default
    path.lineTo(0.0, size.height);
    // Draw a straight line from current point to the top right corner.
    path.lineTo(size.width, 0.0);
    */
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
