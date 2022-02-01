import 'package:flutter/material.dart';

class NeumorphismButtonWhite extends StatelessWidget {
  const NeumorphismButtonWhite({
    Key? key,required this.text
  }) : super(key: key);
  final Widget text ;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  text,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 5,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
