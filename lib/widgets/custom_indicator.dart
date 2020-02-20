import 'package:flutter/material.dart';

class CustomIndicator extends ShapeBorder {
  final double indicatorHeight;
  final Color indicatorColor;

  CustomIndicator(
      {@required this.indicatorHeight, @required this.indicatorColor});

  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    final paint = Paint();
    paint.color = indicatorColor ?? Colors.blue;
    Path path = new Path();

    // draw straight
    path.moveTo(rect.topLeft.dx + 10, rect.topLeft.dy);
    path.lineTo(rect.topLeft.dx + 10, rect.topLeft.dy - indicatorHeight ?? 2);
    path.lineTo(rect.topRight.dx - 10, rect.topRight.dy - indicatorHeight ?? 2);
    path.lineTo(rect.topRight.dx - 10, rect.topRight.dy);

    // draw triangle
    path.moveTo(rect.topCenter.dx, rect.topCenter.dy - 5);
    path.lineTo(rect.topCenter.dx + 5, 0);
    path.lineTo(rect.topCenter.dx - 5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
