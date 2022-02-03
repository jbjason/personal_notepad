import 'package:flutter/material.dart';
import 'package:personal_notepad/provider/my_notesP.dart';
import 'package:personal_notepad/widgets/home_widgets/listitem_container.dart';
import 'package:provider/provider.dart';

class UserNotes extends StatelessWidget {
  const UserNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<MyNotesP>(context);
    final products = productsData.items;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
            child: ListItemContainer(product: products[index]),
          );
        },
        childCount: products.length,
      ),
    );
  }
}
