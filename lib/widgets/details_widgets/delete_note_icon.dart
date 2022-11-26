import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_notepad/provider/my_notesP.dart';

class DeleteNoteIcon extends StatelessWidget {
  const DeleteNoteIcon({Key? key, required this.productsData, required this.id})
      : super(key: key);

  final MyNotesP productsData;
  final String id;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.delete_solid,
          color: Colors.white, size: 26),
      onPressed: () {
        showDialog(
          context: context,
          builder: (c) => CupertinoAlertDialog(
            title: const Text("Are you sure wanna delete this note ?"),
            actions: [
              CupertinoDialogAction(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () async {
                  productsData.deleteItem(id);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
