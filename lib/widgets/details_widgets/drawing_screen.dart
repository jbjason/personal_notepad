import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'package:personal_notepad/widgets/buttonBlack.dart';
import 'package:personal_notepad/widgets/details_widgets/allowPaint_button.dart';

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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.white;
    strokeWidth = 4.0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TitleTextFormFiled
                TtileTextFormField(titleController: _titleController),
                const SizedBox(height: 10),
                // drawing canvas & DescriptionTextField
                Center(child: drawingCanvas(size)),
                const SizedBox(height: 10),
                // button & constract buttons
                buttonAndStroke(size),
                const SizedBox(height: 15),
                // Allow Paint Button
                InkWell(
                  onTap: () => setState(() => _isPaint = !_isPaint),
                  child: AllowPaintAndTextButton(isPaint: _isPaint),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawingCanvas(Size size) {
    return Container(
      height: size.height * .6,
      width: size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: GestureDetector(
        onPanDown: (data) {
          !_isPaint
              ? null
              : setState(
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
          !_isPaint
              ? null
              : setState(
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
        onPanEnd: (_) => setState(() => isEnd = true),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CustomPaint(
            painter: MyCustomPainter(points: initialPoints, isEnd: isEnd),
            // textFormField
            child: DescriptionTextFormField(
              descriptionController: _descriptionController,
              isPaint: _isPaint,
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonAndStroke(Size size) {
    return _isPaint
        ? NeumorphismButtonBlack(
            boxShape: BoxShape.rectangle,
            padding: 3.0,
            text: Row(
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
                  onPressed: () => setState(() => initialPoints.clear()),
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

class TtileTextFormField extends StatelessWidget {
  const TtileTextFormField({
    Key? key,
    required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _titleController,
      cursorColor: Colors.red,
      cursorHeight: 10,
      cursorWidth: 2,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.title_sharp, color: Colors.grey[700]),
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        filled: true,
        fillColor: Colors.grey[900],
      ),
      style: TextStyle(color: Colors.white54, fontSize: 18),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }
}

class DescriptionTextFormField extends StatelessWidget {
  const DescriptionTextFormField({
    Key? key,
    required TextEditingController descriptionController,
    required bool isPaint,
  })  : _descriptionController = descriptionController,
        _isPaint = isPaint,
        super(key: key);

  final TextEditingController _descriptionController;
  final bool _isPaint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        controller: _descriptionController,
        readOnly: _isPaint ? true : false,
        cursorColor: Colors.red,
        cursorHeight: 15,
        cursorWidth: 4,
        decoration: InputDecoration(
          hintText: 'Description',
          hintStyle: TextStyle(color: Colors.white54),
          focusColor: Colors.red,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        style: TextStyle(color: Colors.white, fontSize: 20),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLines: _isPaint ? 2 : 14,
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
    Paint background = Paint()..color = Colors.grey[900]!;
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
