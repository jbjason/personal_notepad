import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/common_widgets/buttonBlack.dart';

class GalleryButton extends StatelessWidget {
  const GalleryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphismButtonBlack(
      padding: 10.0,
      boxShape: BoxShape.rectangle,
      widget: Image.asset('assets/gallery_icon48.png'),
    );
  }
}
