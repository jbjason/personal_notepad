import 'dart:typed_data';
import 'package:flutter/material.dart';

class TestingScreen extends StatelessWidget {
  final Uint8List image;
  const TestingScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.memory(image, fit: BoxFit.cover),
      ),
    );
  }
}
