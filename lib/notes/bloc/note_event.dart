part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class FetchNotes extends NoteEvent {}

final class AddNote extends NoteEvent {
  final String title;
  final String content;

  const AddNote(this.title, this.content);

  @override
  List<Object> get props => [title, content];
}

final class UpdateNote extends NoteEvent {
  final Id id;
  final Note newNote;

  const UpdateNote(this.id, this.newNote);

  @override
  List<Object> get props => [id, newNote];
}

final class DeleteNote extends NoteEvent {
  final Id id;

  const DeleteNote(this.id);

  @override
  List<Object> get props => [id];
}

final class FetchNote extends NoteEvent {
  final Id id;

  const FetchNote(this.id);

  @override
  List<Object> get props => [id];
}