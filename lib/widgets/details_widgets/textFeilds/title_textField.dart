import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleTextFormField extends StatelessWidget {
  const TitleTextFormField({
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
        cursorWidth: 5,
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