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
      height:85,
      width: 85,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          startAngle: 2,
          colors: [Colors.grey[800]!, Colors.blue[200]!],
        ),
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
      child: Padding(
        padding: EdgeInsets.all(10),
        child: FloatingActionButton(
          backgroundColor: Colors.grey[900],
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Icon(CupertinoIcons.pencil_ellipsis_rectangle,
                size: 40, color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(DetailsScreen.routeName);
          },
        ),
      ),
    );
  }
}
