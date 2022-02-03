import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_notepad/models/constants.dart';
import 'package:intl/intl.dart';
import 'package:personal_notepad/models/my_note.dart';
import 'package:personal_notepad/screens/details_screen.dart';

// ignore: must_be_immutable
class ListItemContainer extends StatelessWidget {
  ListItemContainer({Key? key, required this.product}) : super(key: key);

  final MyNote product;

  DateFormat dateFormat = DateFormat("HH:mm    dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    
    String dateString = dateFormat.format(DateTime.now());
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const DetailsScreen()));
      },
      child: Container(
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
                    style: GoogleFonts.permanentMarker(
                      textStyle: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(dateString,
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(height: 10),
                  Text(
                    'The service is referred to by different colloquialisms depending on the region. It may simply be referred to as a "text" in North America, the United Kingdom, Australia, New Zealand, and the Philippines, an "SMS" in most of mainland Europe, or an "MMS" or "SMS" in the Middle East, Africa, and Asia. The sender of a text message is commonly referred to as a "texter".',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: GoogleFonts.architectsDaughter(
                      textStyle: TextStyle(color: textColor, fontSize: 13),
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
      ),
    );
  }

  final boxDecoration = BoxDecoration(
    color: Colors.grey[850],
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      const BoxShadow(
        color: Colors.black,
        offset: Offset(5, 5),
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
