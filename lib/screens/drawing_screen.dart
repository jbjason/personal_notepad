import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'package:personal_notepad/screens/testing_scree.dart';
import 'package:screenshot/screenshot.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({Key? key}) : super(key: key);
  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<DrawingArea> points = [];
  bool isEnd = false;
  late Color selectedColor;
  late double strokeWidth;
  final controller = ScreenshotController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.black;
    strokeWidth = 2.0;
  }

  void selectColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              setState(() => selectedColor = color);
            },
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  Center(child: drawingCanvas(size)),
                  const SizedBox(height: 20),
                  // button & constract buttons
                  buttonAndStroke(size),
                  const SizedBox(height: 20),
                  Container(
                    child: Row(
                      children: [
                        const Spacer(),
                        _isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton.icon(
                                icon: Icon(Icons.save),
                                label: Text('   Save    '),
                                onPressed: () async {
                                  setState(() => _isLoading = true);
                                  final image = await controller
                                      .captureFromWidget(drawingCanvas(size));
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          TestingScreen(image: image)));
                                },
                              ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawingCanvas(Size size) {
    return Container(
      height: size.height * .7,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[200],
      ),
      child: GestureDetector(
        onPanDown: (data) {
          setState(
            () => points.add(DrawingArea(
              point: data.localPosition,
              areaPaint: Paint()
                ..color = selectedColor
                ..strokeWidth = strokeWidth
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.round,
            )),
          );
        },
        onPanUpdate: (data) {
          setState(
            () => points.add(DrawingArea(
              point: data.localPosition,
              areaPaint: Paint()
                ..color = selectedColor
                ..strokeWidth = strokeWidth
                ..isAntiAlias = true
                ..strokeCap = StrokeCap.round,
            )),
          );
        },
        onPanEnd: (_) {
          setState(() => isEnd = true);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CustomPaint(
            painter: MyCustomPainter(points: points, isEnd: isEnd),
          ),
        ),
      ),
    );
  }

  Widget buttonAndStroke(Size size) {
    return Container(
      width: size.width * .8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () => selectColor(),
              icon: Icon(Icons.color_lens, color: selectedColor)),
          Expanded(
            child: Slider(
              min: 1.0,
              max: 7.0,
              activeColor: selectedColor,
              value: strokeWidth,
              onChanged: (val) {
                setState(() => strokeWidth = val);
              },
            ),
          ),
          IconButton(
            onPressed: () => points.clear(),
            icon: Icon(Icons.layers_clear, color: selectedColor),
          ),
        ],
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  MyCustomPainter({required this.isEnd, required this.points});
  final List<DrawingArea> points;
  final bool isEnd;

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.white;
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
