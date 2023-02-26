import 'package:hive/hive.dart';

import '../model/Notes.dart';

class NotesHiveService {
  late Box<Notes> _notes;

  Future<void> init() async {
    try {
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(NotesAdapter());
      }

      _notes = await Hive.openBox('Notes');
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  List<Notes> getAll() {
    try {
      final notes_lst = _notes.values;
      return notes_lst.toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void add(Notes note) {
    _notes.add(note);
  }

  void delete(Notes note) {
    // final deleteNote = _notes.values.firstWhere(
    //     (element) => element == note && element.key as int == index);
    note.delete();
  }

  Future<void> update(Notes note) async {
    try {
      await note.save();
    } catch (e) {
      rethrow;
    }
  }
}
