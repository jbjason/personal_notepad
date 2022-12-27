import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'package:personal_notepad/provider/my_notesP.dart';
import 'package:personal_notepad/widgets/common_widgets/format_image.dart';
import 'package:personal_notepad/widgets/details_widgets/background_canvas.dart';
import 'package:personal_notepad/widgets/details_widgets/details_appbar.dart';
import 'package:personal_notepad/widgets/common_widgets/buttonBlack.dart';
import 'package:personal_notepad/widgets/common_widgets/pick_image.dart';
import 'package:personal_notepad/widgets/details_widgets/image_source_buttons.dart';
import 'package:personal_notepad/widgets/details_widgets/textFeilds/descriptionTextField.dart';
import 'package:personal_notepad/widgets/details_widgets/textFeilds/title_textField.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details-screen';
  const DetailsScreen({Key? key}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<DrawingArea> initialPoints = [];
  bool isEnd = false, _isPaint = false;
  late Color selectedColor;
  late double strokeWidth;
  final controller = ScreenshotController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image, snapImage;
  String _idKey = '';
  int f = 1;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.white;
    strokeWidth = 4.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)!.settings.arguments;
    if (id != null && f == 1) {
      final item = Provider.of<MyNotesP>(context, listen: false)
          .findItemById(id.toString());
      image = item.imageDir != null ? formatImage(item.imageDir!) : null;
      snapImage = item.snapImage != null ? formatImage(item.snapImage!) : null;
      titleController.text = item.title;
      descriptionController.text = item.description;
      _idKey = item.id;
      _dateTime = item.dateTime;
      // cz when deleting this findItemById is called again for Provider listening
      // & after deleting id is null so that findItemById(null id) causes error
      f++;
    }
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
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double canvasHeight = size.height * .6, canvasWidth = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top),
              // AppBar
              DetailsAppBar(
                canvasHeight: canvasHeight,
                canvasWidth: canvasWidth,
                titleController: titleController,
                descriptionController: descriptionController,
                controller: controller,
                initialPoints: initialPoints,
                canvasInBackground: _backgroundCanvas(),
                image: image,
                idKey: _idKey,
              ),
              const SizedBox(height: 7),
              // TitleTextFormFiled
              TitleTextFormField(titleController: titleController),
              // drawing canvas & DescriptionTextField
              _drawingCanvas(canvasHeight, canvasWidth),
              const SizedBox(height: 7),
              // button & constract buttons
              _buttonAndStroke(size),
              const SizedBox(height: 10),
              ImageSourceButtons(
                isPaint: _isPaint,
                enableIsPaint: _enableIsPaint,
                captureImage: _captureImage,
                image: image,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawingCanvas(double height, double width) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          // drawing canvas
          _backgroundCanvas(),
          // Description  textFormField
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: DescriptionTextFormField(
              descriptionController: descriptionController,
              isPaint: _isPaint,
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonAndStroke(Size size) {
    return _isPaint
        ? NeumorphismButtonBlack(
            boxShape: BoxShape.rectangle,
            padding: 3.0,
            widget: Row(
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
                  onPressed: () => setState(() {
                    initialPoints.clear();
                    snapImage = null;
                  }),
                  icon: Icon(Icons.layers_clear, color: selectedColor),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _backgroundCanvas() => BackgroundCanvas(
        onPanDowN: _onPanDown,
        onPanUpdatE: _onPanUpdate,
        onPanEnD: _onPanEnd,
        initialPoints: initialPoints,
        isPaint: _isPaint,
        isEnd: isEnd,
        selectedColor: selectedColor,
        strokeWidth: strokeWidth,
      );

  void _onPanDown(DrawingArea area) {
    setState(() => initialPoints.add(area));
  }

  void _onPanUpdate(DrawingArea area) {
    setState(() => initialPoints.add(area));
  }

  void _onPanEnd() => setState(() => isEnd = true);

  void _captureImage(ImageSource source) async {
    final s = await pickImage(source);
    setState(() => image = s);
  }

  void _enableIsPaint() => setState(() => _isPaint = !_isPaint);

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
