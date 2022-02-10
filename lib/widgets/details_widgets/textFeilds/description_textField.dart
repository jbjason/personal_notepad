import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionTextFormField extends StatelessWidget {
  const DescriptionTextFormField({
    Key? key,
    required TextEditingController descriptionController,
    required bool isPaint,
  })  : _descriptionController = descriptionController,
        _isPaint = isPaint,
        super(key: key);

  final TextEditingController _descriptionController;
  final bool _isPaint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextFormField(
        // initialValue: description,
        controller: _descriptionController,
        readOnly: _isPaint ? true : false,
        cursorColor: Colors.red,
        cursorHeight: 15,
        cursorWidth: 5,
        style: TextStyle(color: Colors.white, fontSize: 20),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLines: _isPaint ? 2 : 12,
        decoration: InputDecoration(
          hintText: 'Description',
          hintStyle: GoogleFonts.neucha(
              textStyle: TextStyle(color: Colors.white54, letterSpacing: 2)),
          focusColor: Colors.red,
          filled: true,
          fillColor: Colors.transparent,
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
