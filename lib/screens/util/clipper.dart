import 'package:flutter/material.dart';

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double _height = 170.0;
    Path path = new Path();
    path.lineTo(0.0, _height - 20);

    var firstControlPoint = new Offset(size.width / 4, _height);
    var firstEndPoint = new Offset(size.width / 2.25, _height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    new Offset(size.width - (size.width / 3.25), _height - 65);
    var secondEndPoint = new Offset(size.width, _height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, _height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}