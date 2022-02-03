import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'package:personal_notepad/models/my_note.dart';
import 'package:personal_notepad/provider/my_notesP.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/camera_button.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/gallery_button.dart';
import 'package:personal_notepad/widgets/details_widgets/image_preview.dart';
import 'package:personal_notepad/widgets/neumorphism%20Button/buttonBlack.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/allowPaint_button.dart';
import 'package:personal_notepad/widgets/details_widgets/myCustomPainter.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<DrawingArea> initialPoints = [];
  bool isEnd = false, _isPaint = false;
  late Color selectedColor;
  late double strokeWidth;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? image;
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
    final productsData = Provider.of<MyNotesP>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            onPressed: () {
              if (_titleController.text.trim().isEmpty) {
                print('Cant save Jb');
              } else {
                productsData.addNote(MyNote(
                  title: _titleController.text.trim(),
                  description: _descriptionController.text.trim(),
                  imageDir: image,
                  dateTime: DateTime.now(),
                  points: initialPoints,
                ));
                Navigator.pop(context);
              }
            },
          ),
          IconButton(
              icon: const Icon(CupertinoIcons.delete_solid), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TitleTextFormFiled
              TtileTextFormField(titleController: _titleController),
              const SizedBox(height: 7),
              // drawing canvas & DescriptionTextField
              Center(child: drawingCanvas(size)),
              const SizedBox(height: 7),
              // button & constract buttons
              buttonAndStroke(size),
              const SizedBox(height: 15),
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
                          onTap: () => _pickImage(ImageSource.gallery),
                          child: GalleryButton(),
                        ),
                        // Camera Button
                        InkWell(
                          onTap: () => _pickImage(ImageSource.camera),
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
                  onPressed: () => setState(() => initialPoints.clear()),
                  icon: Icon(Icons.layers_clear, color: selectedColor),
                ),
              ],
            ),
          )
        : Container();
  }

  Future _pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      final loadImage = File(pickedImage.path);
      setState(() => image = loadImage);
    } on PlatformException catch (error) {
      print('Failed to pick image : $error');
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        controller: _titleController,
        cursorColor: Colors.red,
        cursorHeight: 15,
        cursorWidth: 3,
        style: TextStyle(color: Colors.white, fontSize: 18),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'Title',
          hintStyle: GoogleFonts.neucha(
            textStyle: TextStyle(color: Colors.white70, letterSpacing: 3.5),
          ),
          filled: true,
          fillColor: Colors.grey[900],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
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
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        controller: _descriptionController,
        readOnly: _isPaint ? true : false,
        cursorColor: Colors.red,
        cursorHeight: 15,
        cursorWidth: 3,
        style: TextStyle(color: Colors.white, fontSize: 20),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLines: _isPaint ? 2 : 14,
        decoration: InputDecoration(
          hintText: 'Description',
          hintStyle: GoogleFonts.neucha(
              textStyle: TextStyle(color: Colors.white54, letterSpacing: 2)),
          focusColor: Colors.red,
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
