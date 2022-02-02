import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/neumorphism%20Button/buttonBlack.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphismButtonBlack(
      padding: 20.0,
      boxShape: BoxShape.circle,
      widget: Icon(CupertinoIcons.camera, color: Colors.white, size: 20),
    );
  }
}
