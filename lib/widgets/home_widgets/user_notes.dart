import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color textColor = Colors.white;

// ignore: must_be_immutable
class UserNotes extends StatelessWidget {
  UserNotes({Key? key}) : super(key: key);
  List<String> _myList = [];

  DateFormat dateFormat = DateFormat("HH:mm    dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    String dateTime = dateFormat.format(DateTime.now());
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(dateTime,
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
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
              ),
            ),
          );
        },
        childCount: 10,
      ),
    );
  }
}
