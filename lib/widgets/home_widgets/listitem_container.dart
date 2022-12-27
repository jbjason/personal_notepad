import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_notepad/models/constants.dart';
import 'package:intl/intl.dart';
import 'package:personal_notepad/models/my_note.dart';
import 'package:personal_notepad/screens/details_screen.dart';
import 'package:personal_notepad/widgets/common_widgets/format_image.dart';

class ListItemContainer extends StatelessWidget {
  ListItemContainer({Key? key, required this.product}) : super(key: key);
  final MyNote product;
  final DateFormat dateFormat = DateFormat("HH:mm    dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    String dateString = dateFormat.format(product.dateTime);
    final bool _isEmpty = product.imageDir == null;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailsScreen.routeName, arguments: product.id);
      },
      child: Stack(
        children: [
          ShadowListItemeContainer(),
          Container(
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.permanentMarker(
                          textStyle: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      // datetime
                      Text(dateString,
                          style: TextStyle(color: Colors.grey, fontSize: 11)),
                      const SizedBox(height: 10),
                      // description
                      Text(
                        product.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: GoogleFonts.cinzel(
                          textStyle: TextStyle(
                              color: textColor,
                              fontSize: 13,
                              letterSpacing: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                // image Preview
                !_isEmpty
                    ? Container(
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.file(formatImage(product.imageDir!),
                              fit: BoxFit.cover),
                        ),
                      )
                    : Container(),
              ],
            ),
            padding:
                const EdgeInsets.only(top: 10, bottom: 7, left: 15, right: 10),
            decoration: boxDecoration,
          ),
        ],
      ),
    );
  }

  final boxDecoration = BoxDecoration(
    color: Colors.grey[850],
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(35),
      topRight: Radius.circular(12),
      bottomLeft: Radius.circular(12),
      bottomRight: Radius.circular(35),
    ),
  );
}

class ShadowListItemeContainer extends StatelessWidget {
  const ShadowListItemeContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
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
      ),
    );
  }
}
