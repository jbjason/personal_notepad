import 'package:flutter/material.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'dart:ui';

class MyCustomPainter extends CustomPainter {
  MyCustomPainter({required this.isEnd, required this.points});
  final List<DrawingArea> points;
  final bool isEnd;

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.transparent;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);

    for (int x = 0; x < points.length - 1; x++) {
      final paint = points[x].areaPaint;
      if (points.isNotEmpty && isEnd == false) {
        canvas.drawLine(points[x].point, points[x + 1].point, paint);
      } else if (points.isNotEmpty && isEnd == true) {
        canvas.drawPoints(PointMode.points, [points[x].point], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
