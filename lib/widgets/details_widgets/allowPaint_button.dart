import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/buttonBlack.dart';
import 'package:google_fonts/google_fonts.dart';

class AllowPaintAndTextButton extends StatelessWidget {
  const AllowPaintAndTextButton({
    Key? key,
    required bool isPaint,
  }) : _isPaint = isPaint, super(key: key);

  final bool _isPaint;

  @override
  Widget build(BuildContext context) {
    return NeumorphismButtonBlack(
      boxShape: BoxShape.circle,
      padding: 50.0,
      text: !_isPaint
          ? Icon(Icons.format_paint,
              color: Colors.white, size: 30)
          : Text(
              'Text',
              style: GoogleFonts.lakkiReddy(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
            ),
    );
  }
}