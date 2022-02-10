import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'package:personal_notepad/models/my_note.dart';
import 'package:personal_notepad/provider/my_notesP.dart';
import 'package:personal_notepad/widgets/common_widgets/format_image.dart';
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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? image, snapImage;
  String _id = '';
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
      _titleController.text = item.title;
      _descriptionController.text = item.description;
      _id = item.id;
      _dateTime = item.dateTime;
      // cz when deleting this findItemById is called again for Provider listening
      // & after deleting id is null so that findItemById(null id) causes error
      f++;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<MyNotesP>(context);
    final size = MediaQuery.of(context).size;
    final double canvasHeight = size.height * .6, canvasWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            child: Image.asset('assets/save_icon48.png'),
            onPressed: () async {
              if (_titleController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else {
                final id = DateTime.now().toIso8601String();
                File? loadImage;
                if (initialPoints.isNotEmpty) {
                  // initialPoints empty means no drawing has been done
                  final captureImage = await controller.captureFromWidget(
                      canvasInBackground(canvasHeight, canvasWidth));
                  loadImage = await takeSnapShot(captureImage, id);
                }
                if (_id.isEmpty) {
                  productsData.addNote(MyNote(
                    id: id,
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                    // saving file img & snapImg as String
                    imageDir: image != null ? image.toString() : null,
                    snapImage: loadImage != null ? loadImage.toString() : null,
                    dateTime: DateTime.now(),
                  ));
                } else if (_id.isNotEmpty) {
                  productsData.updateItem(MyNote(
                    id: _id,
                    title: _titleController.text.trim(),
                    description: _descriptionController.text.trim(),
                    imageDir: image != null ? image.toString() : null,
                    snapImage: loadImage != null ? loadImage.toString() : null,
                    dateTime: _dateTime,
                  ));
                }
                Navigator.pop(context);
              }
            },
          ),
          // delete button available if item  existed
          _id.isEmpty
              ? Container()
              : IconButton(
                  icon: const Icon(CupertinoIcons.delete_solid,
                      color: Colors.white, size: 26),
                  onPressed: () {
                    productsData.deleteItem(_id);
                    Navigator.pop(context);
                  },
                ),

          const SizedBox(width: 7),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 7),
              // TitleTextFormFiled
              TitleTextFormField(titleController: _titleController),
              // drawing canvas & DescriptionTextField
              drawingCanvas(size, canvasHeight, canvasWidth),
              const SizedBox(height: 7),
              // button & constract buttons
              buttonAndStroke(size),
              const SizedBox(height: 10),
              Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget drawingCanvas(Size size, double height, double width) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          canvasInBackground(height, width),
          // Description  textFormField
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: DescriptionTextFormField(
                descriptionController: _descriptionController,
                isPaint: _isPaint),
          )
        ],
      ),
    );
  }

  Widget canvasInBackground(double height, double width) {
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

  Widget buttonAndStroke(Size size) {
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

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    shape: StadiumBorder(),
    content: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(colors: [
            Colors.grey[800]!,
            Colors.grey,
            Colors.grey[300]!,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          'Title text can\'t be Empty..!',
          textAlign: TextAlign.center,
          style: GoogleFonts.quintessential(
              color: Colors.black,
              fontSize: 18,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600),
        )),
  );
}
