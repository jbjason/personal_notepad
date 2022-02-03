import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/neumorphism%20Button/buttonBlack.dart';
import 'package:google_fonts/google_fonts.dart';

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
      padding: !_isPaint ? 20.0 : 14,
      widget: !_isPaint
          ? Icon(Icons.brush,
           color: Colors.white, size: 20)
          : Text(
              'Text',
              style: GoogleFonts.lakkiReddy(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
    );
  }
}
