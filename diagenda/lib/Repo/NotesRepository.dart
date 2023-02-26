import '../model/Notes.dart';
import '../services/NotesService.dart';

abstract class INotesRepository {
  void initDB();

  List<Notes> fetchAllNotes();

  void addNote(Notes note);

  void deleteNote(Notes note);

  void updateNote(Notes note);

  List<Notes> getNotesbyDate(DateTime date);
}

class NotesRepository extends INotesRepository {
  NotesRepository({required this.hiveService});
  final NotesHiveService hiveService;
  List<Notes> notes = [];

  @override
  Future<void> initDB() async {
    await hiveService.init();
  }

  @override
  List<Notes> fetchAllNotes() {
    notes = hiveService.getAll();
    return notes;
  }

  @override
  void addNote(Notes note) {
    hiveService.add(note);
  }

  @override
  void updateNote(Notes note) {
    hiveService.update(note);
  }

  @override
  void deleteNote(Notes note) {
    hiveService.delete(note);
  }

  @override
  List<Notes> getNotesbyDate(DateTime date) {
    notes = hiveService.getAll();
    return notes.where((note) => note.timestamp.day == date.day).toList();
  }
}
