import 'package:flutter/cupertino.dart';
import 'package:personal_notepad/models/my_note.dart';

class MyNotesP with ChangeNotifier {
  final List<MyNote> _items = [
    MyNote(
      id: DateTime.now().toIso8601String(),
      title: 'My First Note',
      description:
          'Descriptive Text is a text which says what a person or a thing is like. Its purpose is to describe and reveal a particular person, place, or thing. ... So, it can be said that this descriptive text is a text that explains about whether a person or an object is like, whether its form, its properties, its amount and others ',
      points: [],
      imageDir: null,
      dateTime: DateTime.now(),
    ),
  ];

  List<MyNote> get items {
    return [..._items];
  }

  MyNote findItemById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addNote(MyNote myNote) {
    _items.add(myNote);
    notifyListeners();
  }
}
