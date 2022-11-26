import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_notepad/models/constants.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'package:personal_notepad/models/my_note.dart';
import 'package:personal_notepad/provider/my_notesP.dart';
import 'package:personal_notepad/widgets/common_widgets/format_image.dart';
import 'package:personal_notepad/widgets/details_widgets/delete_note_icon.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/camera_button.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/gallery_button.dart';
import 'package:personal_notepad/widgets/details_widgets/image_preview.dart';
import 'package:personal_notepad/widgets/common_widgets/buttonBlack.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/allowPaint_button.dart';
import 'package:personal_notepad/widgets/details_widgets/myCustomPainter.dart';
import 'package:personal_notepad/widgets/common_widgets/pick_image.dart';
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
                canvasInBackground: canvasInBackground(),
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
              _selectThreeButtons(size),
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
          canvasInBackground(),
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

  Widget canvasInBackground() {
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
          ),
        ),
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

  Widget _selectThreeButtons(Size size) {
    return Row(
      children: [
        Container(
          width: size.width * .6,
          child: Wrap(
            spacing: 7,
            children: [
              //  Paint Button
              InkWell(
                onTap: () => setState(() => _isPaint = !_isPaint),
                child: AllowPaintAndTextButton(isPaint: _isPaint),
              ),
              // Gallery Button
              InkWell(
                onTap: () async {
                  final s = await pickImage(ImageSource.gallery);
                  setState(() => image = s);
                },
                child: GalleryButton(),
              ),
              // Camera Button
              InkWell(
                onTap: () async {
                  final s = await pickImage(ImageSource.camera);
                  setState(() => image = s);
                },
                child: CameraButton(),
              ),
            ],
          ),
        ),
        // Image Preview
        ImagePreviewContainer(size: size, image: image),
      ],
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar(
      {Key? key,
      required this.canvasHeight,
      required this.canvasWidth,
      required this.titleController,
      required this.descriptionController,
      required this.controller,
      required this.initialPoints,
      required this.canvasInBackground,
      required this.image,
      required this.idKey})
      : super(key: key);
  final double canvasHeight;
  final double canvasWidth;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final ScreenshotController controller;
  final List<DrawingArea> initialPoints;
  final Widget canvasInBackground;
  final File? image;
  final String idKey;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<MyNotesP>(context);
    return Container(
      height: kToolbarHeight,
      color: Colors.grey[900],
      child: Row(
        children: [
          IconButton(
            icon: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const Spacer(),
          // Save Icon
          TextButton(
            child: Image.asset('assets/save_icon48.png'),
            onPressed: () async {
              if (titleController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else {
                final id = DateTime.now().toIso8601String();
                File? loadImage;
                // initialPoints empty means no drawing has been done
                if (initialPoints.isNotEmpty) {
                  final captureImage =
                      await controller.captureFromWidget(canvasInBackground);
                  // converting Uni8List to File image & saving it
                  loadImage = await takeSnapShot(captureImage, id);
                }
                productsData.addNote(MyNote(
                  id: id,
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  // saving file img & snapImg as String
                  imageDir: image != null ? image.toString() : null,
                  snapImage: loadImage != null ? loadImage.toString() : null,
                  dateTime: DateTime.now(),
                ));
                Navigator.pop(context);
              }
            },
          ),
          // delete button available if item  existed
          idKey.isNotEmpty
              ? DeleteNoteIcon(productsData: productsData, id: idKey)
              : Container(),
          const SizedBox(width: 7),
        ],
      ),
    );
  }
}
