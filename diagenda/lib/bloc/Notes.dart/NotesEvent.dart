part of 'NotesBloc.dart';

@immutable
abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class LoadNotes extends NotesEvent {
  // final List<Notes> notes;

  const LoadNotes();

  @override
  // TODO: implement propss
  List<Object?> get props => [];
}

// class RegisterService extends NotesEvent {
//   const RegisterService();
//   @override
//   // TODO: implement propss
//   List<Object?> get props => [];
// }

class UpdateNote extends NotesEvent {
  final Notes note;
  const UpdateNote({required this.note});

  @override
  // TODO: implement propss
  List<Object?> get props => [note];
}

class DeleteNote extends NotesEvent {
  final Notes note;
  const DeleteNote({required this.note});
  @override
  // TODO: implement propss
  List<Object?> get props => [note];
}

class SearchNote extends NotesEvent {
  final String query;
  const SearchNote({required this.query});
  @override
  // TODO: implement propss
  List<Object?> get props => [query];
}

class RegisterNoteService extends NotesEvent {
  const RegisterNoteService();
  @override
  // TODO: implement propss
  List<Object?> get props => [];
}

class SortNotesList extends NotesEvent {
  final int order;
  const SortNotesList({required this.order});
  @override
  List<Object?> get props => [order];
}

class SaveNote extends NotesEvent {
  final Notes note;
  final Enum noteAction;

  const SaveNote({required this.note, required this.noteAction});

  @override
  List<Object?> get props => [note];
}
