import 'package:flutter/material.dart';

class WeirdBorder extends ShapeBorder {
  final double radius;
  final double pathWidth;
  final bool bottom;
  final top;

  WeirdBorder({
    required this.radius,
    this.pathWidth = 1,
    this.bottom = false,
    this.top = false,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  ShapeBorder scale(double t) => WeirdBorder(radius: radius);

  Path _createPath(Rect rect) {
    final innerRadius = radius + pathWidth;
    final innerRect = Rect.fromLTRB(rect.left + pathWidth, rect.top + pathWidth,
        rect.right - pathWidth, rect.bottom - pathWidth);

    final outer = Path.combine(PathOperation.difference, Path()..addRect(rect),
        _createBevels(rect, radius));
    final inner = Path.combine(PathOperation.difference,
        Path()..addRect(innerRect), _createBevels(rect, innerRadius));
    return Path.combine(PathOperation.difference, outer, inner);
  }

  Path _createBevels(Rect rect, double radius) {
    if (bottom)
      return Path()
        ..addOval(
          Rect.fromCircle(
            center: Offset(rect.left, rect.top + rect.height),
            radius: radius,
          ),
        )
        ..addOval(
          Rect.fromCircle(
            center: Offset(rect.left + rect.width, rect.top + rect.height),
            radius: radius,
          ),
        );
    else if (top) {
      return Path()
        ..addOval(Rect.fromCircle(
          center: Offset(rect.left, rect.top),
          radius: radius,
        ))
        ..addOval(Rect.fromCircle(
          center: Offset(rect.left + rect.width, rect.top),
          radius: radius,
        ));
    } else {
      return Path()
        ..addOval(Rect.fromCircle(
          center: Offset(rect.left, rect.top),
          radius: radius,
        ))
        ..addOval(Rect.fromCircle(
          center: Offset(rect.left + rect.width, rect.top),
          radius: radius,
        ))
        ..addOval(Rect.fromCircle(
          center: Offset(rect.left, rect.top + rect.height),
          radius: radius,
        ))
        ..addOval(
          Rect.fromCircle(
            center: Offset(rect.left + rect.width, rect.top + rect.height),
            radius: radius,
          ),
        );
    }
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect, textDirection: textDirection), Offset.zero);

    // throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _createPath(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
}
