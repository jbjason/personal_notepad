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
import 'package:personal_notepad/widgets/common_widgets/format_image.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/camera_button.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/gallery_button.dart';
import 'package:personal_notepad/widgets/details_widgets/image_preview.dart';
import 'package:personal_notepad/widgets/common_widgets/buttonBlack.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/allowPaint_button.dart';
import 'package:personal_notepad/widgets/details_widgets/myCustomPainter.dart';
import 'package:personal_notepad/widgets/home_widgets/pick_image.dart';
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
  var snapshotImage;
  File? image;
  String _id = '';

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
    if (id != null) {
      final item = Provider.of<MyNotesP>(context, listen: false)
          .findItemById(id.toString());
      initialPoints = item.points;
      image = item.imageDir != null ? formatImage(item.imageDir!) : null;
      _titleController.text = item.title;
      _descriptionController.text = item.description;
      _id = item.id;
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
            onPressed: () async {
              if (_titleController.text.trim().isEmpty) {
                print('Cant save Jb');
              } else {
                final descText = _descriptionController.text.trim();
                if (initialPoints.isNotEmpty) {
                  _descriptionController.text = ' ';
                  //  setState(() => _isDrawing = true);
                  final captureImage =
                      await controller.captureFromWidget(drawingCanvas(size));
                  //final loadImage = await takeSnapShot(captureImage);
                  setState(() => snapshotImage = captureImage);
                  print('jb \n jason');
                  var s = snapshotImage.toString();
                  print(s);
                }
                // productsData.addNote(MyNote(
                //   id: DateTime.now().toIso8601String(),
                //   title: _titleController.text.trim(),
                //   description: descText,
                //   // saving file img as String
                //   imageDir: image != null ? image.toString() : null,
                //   dateTime: DateTime.now(),
                //   points: initialPoints,
                // ));
                //   Navigator.pop(context);
              }
            },
          ),
          // delete button
          IconButton(
            icon: const Icon(CupertinoIcons.delete_solid),
            onPressed: () {
              if (_id.isNotEmpty) {
                productsData.deleteItem(_id);
                Navigator.of(context).pop();
              }
            },
          ),
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

  Widget drawingCanvas(Size size) {
    return Container(
      height: size.height * .6,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[900],
        image: snapshotImage == null
            ? DecorationImage(image: AssetImage('assets/brush.jpg'))
            : DecorationImage(image: MemoryImage(snapshotImage)),
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
            // textFormField
            // child: DescriptionTextFormField(
            //     descriptionController: _descriptionController,
            //     isPaint: _isPaint),
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
        //initialValue: title,
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
        // initialValue: description,
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
