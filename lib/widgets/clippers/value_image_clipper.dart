import 'package:flutter/material.dart';

class ValueImageClipper extends CustomClipper<Path> {
  ValueImageClipper({this.borderRadius = 15});
  final double borderRadius;
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.cubicTo(
      borderRadius,
      0.0,
      0.0,
      0.0,
      0.0,
      borderRadius,
    );

    path.lineTo(0.0, size.height);
    path.lineTo(5, size.height);

    double x = 3;
    double y = size.height;
    double yControlPoint = size.height * .88;
    double increment = (size.width - 6) / 22;

    while (x < size.width) {
      path.quadraticBezierTo(
        (x + increment / 2),
        yControlPoint,
        x + increment - 2,
        y,
      );
      path.lineTo(x + increment + 2, y);
      x += increment;
    }
    // path.lineTo(size.width - increment + 30, size.height);

    path.cubicTo(
      size.width + 2,
      borderRadius,
      size.width + 2,
      0.0,
      size.width - borderRadius,
      0.0,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return false;
  }
}
