import 'package:flutter/material.dart';
import 'package:personal_notepad/models/constants.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ListItemContainer extends StatelessWidget {
  ListItemContainer({Key? key}) : super(key: key);

  DateFormat dateFormat = DateFormat("HH:mm    dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    String dateString = dateFormat.format(DateTime.now());
    return Container(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(dateString,
                    style: TextStyle(color: Colors.grey, fontSize: 11)),
                const SizedBox(height: 10),
                Text(
                  'Hello asfba asdhgajs asyfgasgjash ahghajhgaj.ash ashgaj hg Hello asfba asdhgajs asyfgasgjash ahghajhgaj',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset('assets/brush.jpg', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
      decoration: boxDecoration,
    );
  }

  final boxDecoration = BoxDecoration(
    color: Colors.grey[850],
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      const BoxShadow(
        color: Colors.black,
        offset: Offset(4, 4),
        blurRadius: 15,
        spreadRadius: 5,
      ),
      BoxShadow(
        color: Colors.grey.shade800,
        offset: const Offset(-5, -5),
        blurRadius: 15,
        spreadRadius: 1,
      ),
    ],
  );
}
