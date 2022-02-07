import 'package:personal_notepad/models/drawing_area.dart';

class MyNote {
  final String title, description,id;
  final String? imageDir;
  final List<DrawingArea> points;
  final DateTime dateTime;
  const MyNote({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.imageDir,
    required this.dateTime,
  });
}
