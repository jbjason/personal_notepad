import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/allowPaint_button.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/camera_button.dart';
import 'package:personal_notepad/widgets/details_widgets/details_button/gallery_button.dart';
import 'package:personal_notepad/widgets/details_widgets/image_preview.dart';

class ImageSourceButtons extends StatelessWidget {
  const ImageSourceButtons({
    Key? key,
    required this.enableIsPaint,
    required this.captureImage,
    required this.isPaint,
    this.image,
  }) : super(key: key);
  final Function enableIsPaint;
  final Function captureImage;
  final File? image;
  final bool isPaint;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          width: size.width * .6,
          child: Wrap(
            spacing: 7,
            children: [
              //  Paint Button
              InkWell(
                onTap: () => enableIsPaint(),
                child: AllowPaintAndTextButton(isPaint: isPaint),
              ),
              // Gallery Button
              InkWell(
                onTap: () => captureImage(ImageSource.gallery),
                child: GalleryButton(),
              ),
              // Camera Button
              InkWell(
                onTap: () => captureImage(ImageSource.camera),
                child: CameraButton(),
              ),
            ],
          ),
        ),
        // Image Preview
        ImagePreviewContainer(size: size, image: image),
      ],
    );
  }
}
