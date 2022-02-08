import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);
  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  final controller = ScreenshotController();
  var image;
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: image == null
                    ? Text('No Images')
                    : ImageContainer(img: image),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final loadImage = await controller.capture();
                  if(loadImage!=null){
                    setState(() => image = loadImage );
                  }
                },
                icon: Icon(Icons.hail, color: Colors.white),
                label: Text(
                  'Capture ScreenShot',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key, required this.img}) : super(key: key);
  final img;

  @override
  Widget build(BuildContext context) {
    return Image.memory(img);
  }
}
