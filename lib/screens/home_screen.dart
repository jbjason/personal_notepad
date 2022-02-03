import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_notepad/screens/details_screen.dart';
import 'package:personal_notepad/widgets/home_widgets/appBarDelegate.dart';
import 'package:personal_notepad/widgets/home_widgets/bodyTopParts.dart';
import 'package:personal_notepad/widgets/home_widgets/user_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: AppBarDelegate(expandedHeight: size.height * .36),
          ),
          SliverToBoxAdapter(child: BodyTopParts()),
          UserNotes(),
          // SliverToBoxAdapter(child: Placeholder(color: Colors.transparent)),
          // SliverToBoxAdapter(child: Placeholder(color: Colors.transparent)),
        ],
      ),
      floatingActionButton: AddNewNoteButton(),
    );
  }
}

class AddNewNoteButton extends StatelessWidget {
  const AddNewNoteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 75,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
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
      child: FloatingActionButton(
        backgroundColor: Colors.grey[900],
        child: Icon(
          CupertinoIcons.pencil_ellipsis_rectangle,
          color: Colors.deepOrange[300],
          size: 40,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const DetailsScreen()));
        },
      ),
    );
  }
}
