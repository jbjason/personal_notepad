import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/common_widgets/buttonBlack.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Jb Jason'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Container(child: Image.asset('assets/save_icon48.png')),
          ),
          Icon(Icons.delete, size: 28),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Row(
          children: [
            NeumorphismButtonBlack(
              padding: 10.0,
              boxShape: BoxShape.circle,
              widget: Image.asset('assets/paint_icon48.png'),
            ),
            const SizedBox(width: 10),
            NeumorphismButtonBlack(
              padding: 10.0,
              boxShape: BoxShape.circle,
              widget: Image.asset('assets/camera_icon48.png'),
            ),
            const SizedBox(width: 10),
            NeumorphismButtonBlack(
              padding: 10.0,
              boxShape: BoxShape.circle,
              widget: Image.asset('assets/gallery_icon48.png'),
            ),
          ],
        ),
      ),
    );
  }
}
