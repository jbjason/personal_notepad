import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'package:screenshot/screenshot.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({Key? key}) : super(key: key);
  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<DrawingArea> initialPoints = [];
  bool isEnd = false, _isPaint = false;
  late Color selectedColor;
  late double strokeWidth;
  final controller = ScreenshotController();

  @override
  void initState() {
    super.initState();
    // initial color & selected color object
    selectedColor = Colors.black;
    strokeWidth = 4.0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              children: [
                Container(),
                // drawing canvas & TextField
                Center(child: drawingCanvas(size)),
                const SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() => _isPaint = !_isPaint);
                    },
                    icon: Icon(Icons.format_paint_sharp),
                    label: Text('Paint'),
                  ),
                ),
                const SizedBox(height: 20),
                // button & constract buttons
                buttonAndStroke(size),
                const SizedBox(height: 20),
                // Save Button
                SaveButton(),
              ],
            ),
          ),
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
         !_isPaint ?null:  setState(
            () => initialPoints.add(DrawingArea(
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
         !_isPaint ?null: setState(
            () => initialPoints.add(DrawingArea(
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
            painter: MyCustomPainter(points: initialPoints, isEnd: isEnd),
            child: TextFormField(
              initialValue: '',
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Write here.......',
              ),
              textInputAction: TextInputAction.done,
              maxLines: 3,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonAndStroke(Size size) {
    return _isPaint
        ? Container(
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
                    min: 3.0,
                    max: 10.0,
                    activeColor: selectedColor,
                    value: strokeWidth,
                    onChanged: (val) {
                      setState(() => strokeWidth = val);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () => initialPoints.clear(),
                  icon: Icon(Icons.layers_clear, color: selectedColor),
                ),
              ],
            ),
          )
        : Container();
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
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const Spacer(),
          ElevatedButton.icon(
            icon: Icon(Icons.save),
            label: Text('   Save    '),
            onPressed: () async {
              // final image = await controller
              //     .captureFromWidget(drawingCanvas(size));
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (_) =>
              //         TestingScreen(image: image)));
            },
          ),
          const SizedBox(width: 20),
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
