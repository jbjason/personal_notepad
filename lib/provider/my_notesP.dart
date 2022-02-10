import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:personal_notepad/models/my_note.dart';

class MyNotesP with ChangeNotifier {
  List<MyNote> _items = [];

  List<MyNote> get items {
    return [..._items];
  }

  void initializeItems(List<MyNote> mynotes) {
    _items = [...mynotes];
  }

  MyNote findItemById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void deleteItem(String id) {
    final exIndex = _items.indexWhere((element) => element.id == id);
    final MyNote myNote = _items[exIndex];
    myNote.delete();
    _items.removeAt(exIndex);
  }

  void updateItem(MyNote myNote) async {
    final exIndex = _items.indexWhere((element) => element.id == myNote.id);
    await Hive.box<MyNote>('myNote').putAt(exIndex, myNote);
  }

  void addNote(MyNote myNote) {
    Hive.box<MyNote>('myNote').add(myNote);
  }
}
