import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_notepad/models/my_note.dart';
import 'package:personal_notepad/provider/my_notesP.dart';
import 'package:personal_notepad/screens/details_screen.dart';
import 'package:personal_notepad/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<MyNote>(MyNoteAdapter());
  await Hive.openBox<MyNote>('myNote');
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
        //home: const TestingScreen(),
        home: const HomeScreen(),
        routes: {
          DetailsScreen.routeName: (ctx) => DetailsScreen(),
        },
      ),
    );
  }
}
