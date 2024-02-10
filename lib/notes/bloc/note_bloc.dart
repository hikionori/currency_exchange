import 'package:bloc/bloc.dart';
import 'package:currency_exchange/app/constants.dart';
import 'package:currency_exchange/notes/models/note_model.dart';
import 'package:currency_exchange/notes/services/note_service.dart';
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteService noteService = getIt.get<NoteService>();

  NoteBloc() : super(NotesInitial()) {
    on<NoteEvent>((event, emit) async {
      switch (event.runtimeType) {
        case FetchNotes:
          await _handleFetchNotes(emit);
          break;
        case AddNote:
          await _handleAddNote(event, emit);
          break;
        case UpdateNote:
          await _handleUpdateNote(event, emit);
          break;
        case DeleteNote:
          await _handleDeleteNote(event, emit);
          break;
        case FetchNote:
          await _handleFetchNote(event, emit);
          break;
      }
    });
  }

  Future<void> _handleFetchNote(
      NoteEvent event, Emitter<NoteState> emit) async {
    final FetchNote fetchNote = event as FetchNote;
    emit(NoteLoading());
    try {
      final note = await noteService.getNoteById(fetchNote.id);
      emit(NoteLoaded(note));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> _handleDeleteNote(
      NoteEvent event, Emitter<NoteState> emit) async {
    final DeleteNote deleteNote = event as DeleteNote;
    try {
      await noteService.deleteNoteById(deleteNote.id);
      add(FetchNotes());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _handleUpdateNote(
      NoteEvent event, Emitter<NoteState> emit) async {
    final UpdateNote updateNote = event as UpdateNote;
    try {
      await noteService.updateNote(updateNote.id, updateNote.newNote);
      add(FetchNotes());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _handleAddNote(NoteEvent event, Emitter<NoteState> emit) async {
    final AddNote addNote = event as AddNote;
    try {
      await noteService.createNote(addNote.title, addNote.content);
      add(FetchNotes());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _handleFetchNotes(Emitter<NoteState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await noteService.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}
