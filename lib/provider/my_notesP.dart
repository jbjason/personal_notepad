import 'package:flutter/cupertino.dart';
import 'package:personal_notepad/models/my_note.dart';

class MyNotesP with ChangeNotifier {
  final List<MyNote> _items = [];

  List<MyNote> get items {
    return [..._items];
  }

  MyNote findItemById(String s) {
    return _items.firstWhere((element) => element.id == s);
  }

  void addNote(MyNote myNote) {
    _items.add(myNote);
    notifyListeners();
  }
}
