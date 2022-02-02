import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreviewContainer extends StatelessWidget {
  const ImagePreviewContainer({
    Key? key,
    required this.size,
    required this.image,
  }) : super(key: key);

  final Size size;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return image == null
        ? Container()
        : Container(
            width: size.width * .4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.file(image!, height: 160, fit: BoxFit.cover),
            ),
          );
  }
}
