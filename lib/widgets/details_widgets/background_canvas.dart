import 'dart:io';
import 'package:flutter/material.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'package:personal_notepad/widgets/details_widgets/myCustomPainter.dart';

class BackgroundCanvas extends StatelessWidget {
  const BackgroundCanvas(
      {Key? key,
      required this.onPanDowN,
      required this.onPanUpdatE,
      required this.onPanEnD,
      required this.initialPoints,
      required this.isPaint,
      required this.isEnd,
      required this.selectedColor,
      required this.strokeWidth,
      this.snapImage})
      : super(key: key);
  final Function onPanDowN, onPanUpdatE, onPanEnD;
  final List<DrawingArea> initialPoints;
  final bool isPaint, isEnd;
  final Color selectedColor;
  final double strokeWidth;
  final File? snapImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height * .6, width = size.width;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[900],
        image: snapImage == null
            ? DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover)
            : DecorationImage(
                image: FileImage(snapImage!), fit: BoxFit.fitHeight),
      ),
      child: GestureDetector(
        onPanDown: (data) {
          if (isPaint) {
            final area = DrawingArea(
              point: data.localPosition,
              areaPaint: Paint()
                ..color = selectedColor
                ..strokeWidth = strokeWidth
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.round,
            );
            onPanDowN(area);
          }
        },
        onPanUpdate: (data) {
          if (isPaint) {
            final area = DrawingArea(
              point: data.localPosition,
              areaPaint: Paint()
                ..color = selectedColor
                ..strokeWidth = strokeWidth
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.round,
            );
            onPanUpdatE(area);
          }
        },
        onPanEnd: (_) => onPanEnD,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CustomPaint(
            painter: MyCustomPainter(points: initialPoints, isEnd: isEnd),
          ),
        ),
      ),
    );
  }
}
