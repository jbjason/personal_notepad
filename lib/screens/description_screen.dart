import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({Key? key}) : super(key: key);
  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        leading: IconButton(
          icon:const Icon(CupertinoIcons.arrow_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon:const Icon(CupertinoIcons.smiley))
        ],
      ),
    );
  }
}
