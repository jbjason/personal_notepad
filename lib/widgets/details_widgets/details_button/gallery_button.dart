import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/common_widgets/buttonBlack.dart';

class GalleryButton extends StatelessWidget {
  const GalleryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphismButtonBlack(
      padding: 20.0,
      boxShape: BoxShape.rectangle,
      widget: Icon(Icons.image_outlined, color: Colors.white, size: 20),
    );
  }
}
