import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/common_widgets/buttonBlack.dart';

class AllowPaintAndTextButton extends StatelessWidget {
  const AllowPaintAndTextButton({
    Key? key,
    required bool isPaint,
  })  : _isPaint = isPaint,
        super(key: key);

  final bool _isPaint;

  @override
  Widget build(BuildContext context) {
    return NeumorphismButtonBlack(
      boxShape: BoxShape.circle,
      padding: 10,
      widget: !_isPaint
          ? Image.asset('assets/paint_icon48.png')
          : Image.asset('assets/paint_close48.png'),
    );
  }
}
