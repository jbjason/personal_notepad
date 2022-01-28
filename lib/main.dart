import 'package:flutter/material.dart';
import 'package:personal_notepad/screens/custom_clipper_screen.dart';
import 'package:personal_notepad/screens/drawing_screen.dart';
import 'package:personal_notepad/screens/snapshot_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const DrawingScreen(),
    );
  }
}
