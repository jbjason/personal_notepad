import 'package:flutter/material.dart';
import 'package:personal_notepad/widgets/home_widgets/appBarDelegate.dart';
import 'package:personal_notepad/widgets/home_widgets/user_notes.dart';

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
          SliverToBoxAdapter(child: UserNotes()),
        ],
      ),
    );
  }
}
