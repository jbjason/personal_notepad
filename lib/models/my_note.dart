import 'package:hive/hive.dart';
part 'my_note.g.dart';

@HiveType(typeId: 02)
class MyNote extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final String? imageDir;
  @HiveField(4)
  final String? snapImage;
  @HiveField(5)
  final DateTime dateTime;
  MyNote({
    required this.id,
    required this.title,
    required this.description,
    required this.snapImage,
    required this.imageDir,
    required this.dateTime,
  });
}
