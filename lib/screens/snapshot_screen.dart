import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class SnapshotScreen extends StatefulWidget {
  const SnapshotScreen({Key? key}) : super(key: key);
  @override
  State<SnapshotScreen> createState() => _SnapshotScreenState();
}

class _SnapshotScreenState extends State<SnapshotScreen> {
  final controller = ScreenshotController();
  bool _isTaken = false;
  late final takenImage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            buildImage(),
            ElevatedButton(
              onPressed: () async {
                final image = await controller.captureFromWidget(buildImage());
                setState(() {
                  _isTaken = true;
                  takenImage = image;
                });
              },
              child: Text('Take ScreenShot'),
            ),
            _isTaken
                ? Container(
                    child: Image.memory(
                      takenImage,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Image.asset('assets/brush.jpg', fit: BoxFit.cover);
  }
}
