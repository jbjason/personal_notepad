
class MyNote {
  final String title;
  final String description;
  final String id;
  final String? imageDir;
  final String? snapImage;
  final DateTime dateTime;
  const MyNote({
    required this.id,
    required this.title,
    required this.description,
    required this.snapImage,
    required this.imageDir,
    required this.dateTime,
  });
}
