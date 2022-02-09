import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/common_widgets/buttonBlack.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphismButtonBlack(
      padding: 10.0,
      boxShape: BoxShape.circle,
      widget: Image.asset('assets/camera_icon48.png'),
    );
  }
}
