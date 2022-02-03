import 'dart:io';

import 'package:personal_notepad/models/drawing_area.dart';

class MyNote {
  final String title, description;
  final File? imageDir;
  final List<DrawingArea> points;
  const MyNote({
    required this.title,
    required this.description,
    required this.points,
    required this.imageDir,
  });
}
