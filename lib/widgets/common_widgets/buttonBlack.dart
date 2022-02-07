import 'package:flutter/material.dart';

class NeumorphismButtonBlack extends StatelessWidget {
  const NeumorphismButtonBlack({
    Key? key,
    required this.widget,
    required this.padding,
    required this.boxShape,
  }) : super(key: key);
  final Widget widget;
  final double padding;
  final BoxShape boxShape;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        shape: boxShape,
        boxShadow: [
          const BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: Colors.grey.shade800,
            offset: const Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
