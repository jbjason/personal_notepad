import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future pickImage(ImageSource source) async {
  try {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final directory = await getApplicationDocumentsDirectory();
      final name = basename(pickedImage.path);
      final image = File('${directory.path}/$name');
      return File(pickedImage.path).copy(image.path);
    }
  } on PlatformException catch (error) {
    print('Failed to pick image : $error');
  }
}

Future takeSnapShot(var pickedImage, String id) async {
  // Unit8List image to File convertion
  try {
    final tempDir = await getApplicationDocumentsDirectory();
    File file = await File('${tempDir.path}/$id.png').create();
    file.writeAsBytesSync(pickedImage);
    return file;
  } on PlatformException catch (error) {
    print('Failed to pick image : $error');
  }
}
