import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_notepad/models/constants.dart';
import 'package:personal_notepad/models/drawing_area.dart';
import 'package:personal_notepad/models/my_note.dart';
import 'package:personal_notepad/provider/my_notesP.dart';
import 'package:personal_notepad/widgets/common_widgets/pick_image.dart';
import 'package:personal_notepad/widgets/details_widgets/delete_note_icon.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

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
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Spacer(),
          // Save Icon
          TextButton(
            child: Icon(Icons.save_outlined),
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
