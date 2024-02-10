part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NotesInitial extends NoteState {}

final class NotesLoading extends NoteState {}

final class NotesLoaded extends NoteState {
  final List<Note> notes;

  const NotesLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}

final class NotesError extends NoteState {
  final String message;

  const NotesError(this.message);

  @override
  List<Object> get props => [message];
}

final class NoteLoading extends NoteState {}

final class NoteLoaded extends NoteState {
  final Note note;

  const NoteLoaded(this.note);

  @override
  List<Object> get props => [note];
}

final class NoteError extends NoteState {
  final String message;

  const NoteError(this.message);

  @override
  List<Object> get props => [message];
}

