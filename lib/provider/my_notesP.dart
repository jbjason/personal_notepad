import 'package:flutter/cupertino.dart';
import 'package:personal_notepad/models/my_note.dart';

class MyNotesP with ChangeNotifier {
  final List<MyNote> _items = [];

  List<MyNote> get items {
    return [..._items];
  }

  void addNote(MyNote myNote) {
    _items.add(myNote);
    notifyListeners();
  }
}
