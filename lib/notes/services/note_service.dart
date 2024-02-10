import 'package:currency_exchange/app/constants.dart';
import 'package:currency_exchange/notes/models/note_model.dart';
import 'package:isar/isar.dart';

class NoteService {
  Isar isar = getIt.get<Isar>();

  Future<List<Note>> getNotes() async {
    final result = await isar.notes.where().findAll();
    return result;
  }

  Future<Note> getNoteById(Id id) async {
    final result = await isar.notes.where().idEqualTo(id).findFirst();
    if (result == null) {
      throw Exception('Note not found');
    }
    return result;
  }

  Future<void> createNote(String title, String content) async {
    final note = Note()
      ..title = title
      ..content = content
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });
  }

  Future<void> updateNote(Id id, Note newNote) async {
    final note = await isar.notes.where().idEqualTo(id).findFirst();
    if (note == null) {
      throw Exception('Note not found');
    }

    await isar.writeTxn(() async {
      note.title = newNote.title;
      note.content = newNote.content;
      note.updatedAt = DateTime.now();
      await isar.notes.put(note);
    });
  }

  Future<void> deleteNoteById(Id id) async {
    await isar.writeTxn(() async {
      await isar.notes.where().idEqualTo(id).deleteAll();
    });
  }
}
