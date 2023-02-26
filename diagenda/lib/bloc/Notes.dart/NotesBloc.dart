//import 'package:diagenda/Repo/NotesRepo.dart';
import 'package:diagenda/Repo/NotesRepository.dart';
import 'package:diagenda/enumerations.dart';
import 'package:diagenda/model/Notes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/cupertino.dart';

part 'NotesEvent.dart';
part 'NotesState.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesRepository notesRepo;
  NotesBloc({required this.notesRepo})
      : super(const RegisteringServiceState()) {
    on<LoadNotes>(_onLoadNotes);
    on<SaveNote>(_onSaveNote);
    on<DeleteNote>(_onDeleteNote);
    on<RegisterNoteService>(_onRegisterService);
    on<SortNotesList>(_onSortNoteList);
    on<SearchNote>(_onSearchNote);
  }
  _onRegisterService(event, Emitter<NotesState> emit) async {
    await notesRepo.initDB();
    emit(const NotesLoading());
  }

  void _onLoadNotes(event, Emitter<NotesState> emit) {
    //emit(const NotesLoading());
    List<Notes> notes = notesRepo.fetchAllNotes();

    emit(NotesLoaded(notes: notes));
  }

  void _onSearchNote(event, Emitter<NotesState> emit) {
    final state = this.state;
    List<Notes> notes_temp = [];

    if (state is NotesLoaded) {
      // notes_temp = state.notes.toList();
      //state.notes.any((element) => )
      for (var element in state.notes) {
        if (element.title.toLowerCase().contains(event.query)) {
          notes_temp.add(element);
        }
      }
    }

    emit(NotesLoaded(notes: notes_temp));

    return;
  }

  void _onSortNoteList(event, Emitter<NotesState> emit) {
    final state = this.state;
    List<Notes> notes_temp = [];

    if (state is NotesLoaded) {
      notes_temp = state.notes.toList();
      if (event.order == 0) {
        notes_temp.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      } else {
        notes_temp.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      }
    }

    emit(NotesLoaded(notes: notes_temp));

    return;
  }

  void _onSaveNote(event, Emitter<NotesState> emit) {
    final state = this.state;
    List<Notes> notes_temp;

    emit(const NotesLoading());
    if (event.noteAction == NoteAction.edit) {
      notesRepo.updateNote(event.note);
    }
    if (event.noteAction == NoteAction.add) {
      notesRepo.addNote(event.note);
    }

    //notes_temp.add(event.note);
    notes_temp = notesRepo.fetchAllNotes();

    emit(NotesLoaded(notes: notes_temp));
    print(this.state);
    return;
  }

  void _onDeleteNote(event, Emitter<NotesState> emit) {
    final state = this.state;
    List<Notes> notes_temp;
    if (state is NotesLoaded) {
      // notes_temp = state.notes;
      emit(const NotesLoading());
      notesRepo.deleteNote(event.note);
      notes_temp = notesRepo.fetchAllNotes();
      // print('herre in the bloc---------------------------------');
      // print(event.note);
      // print(event.note.key);
      // print(notes_temp.length);
      // notes_temp.removeWhere((element) => element == event.note);
      // print(
      //     'herre in the bloc done executing---------------------------------');
      // print(notes_temp.length);
      // notesRepo.setNote(notes_temp);
      emit(NotesLoaded(notes: notes_temp));
      return;
    }
  }
}
