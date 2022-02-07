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
          SliverToBoxAdapter(child: Placeholder(color: Colors.transparent)),
          // SliverToBoxAdapter(child: Placeholder(color: Colors.transparent)),
        ],
      ),
      floatingActionButton: FloatingButtonAdd(),
    );
  }
}

class FloatingButtonAdd extends StatelessWidget {
  const FloatingButtonAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          startAngle: 2,
          colors: [Colors.black87, Colors.blue[200]!],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red[900]!,
            offset: const Offset(1, 1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black,
            offset: const Offset(-5, -5),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: FloatingActionButton(
          backgroundColor: Colors.black87,
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
