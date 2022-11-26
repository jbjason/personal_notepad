import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color textColor = Colors.white;

final snackBar = SnackBar(
  backgroundColor: Colors.transparent,
  duration: Duration(seconds: 2),
  behavior: SnackBarBehavior.floating,
  shape: StadiumBorder(),
  content: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(colors: [
          Colors.grey[800]!,
          Colors.grey,
          Colors.grey[300]!,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Text(
        'Title text can\'t be Empty..!',
        textAlign: TextAlign.center,
        style: GoogleFonts.quintessential(
            color: Colors.black,
            fontSize: 18,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600),
      )),
);
