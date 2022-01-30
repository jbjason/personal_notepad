import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BodyTopParts extends StatelessWidget {
  const BodyTopParts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          const Spacer(),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.align_horizontal_center_sharp, color: Colors.grey),
            label: Text(
              'Date modified   |',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Icon(
            CupertinoIcons.arrow_up,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
