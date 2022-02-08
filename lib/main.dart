import 'package:flutter/material.dart';
import 'package:personal_notepad/provider/my_notesP.dart';
import 'package:personal_notepad/screens/details_screen.dart';
import 'package:personal_notepad/screens/home_screen.dart';
import 'package:personal_notepad/screens/testing_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyNotesP(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const HomeScreen(),
        routes: {
          DetailsScreen.routeName: (ctx) => DetailsScreen(),
        },
      ),
    );
  }
}
