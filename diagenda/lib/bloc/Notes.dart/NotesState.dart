part of 'NotesBloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesLoaded extends NotesState {
  final List<Notes> notes;
  const NotesLoaded({required this.notes});

  @override
  // TODO: implement propss
  List<Object?> get props => [notes];

  NotesLoaded copyWith({List<Notes>? notes}) {
    return NotesLoaded(notes: notes ?? this.notes);
  }
}

class NotesLoading extends NotesState {
  const NotesLoading();

  @override
  // TODO: implement propss
  List<Object?> get props => [];
}

class RegisteringServiceState extends NotesState {
  const RegisteringServiceState();

  @override
  // TODO: implement propss
  List<Object?> get props => [];
}
// class NotesSaved extends NotesState {
//   final List<Notes> notes;
//   const NotesSaved({required this.notes});

//   @override
//   // TODO: implement propss
//   List<Object?> get props => [notes];
// }
