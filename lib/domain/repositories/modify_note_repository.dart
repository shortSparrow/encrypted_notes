import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/domain/models/notes.dart';

abstract class ModifyNoteRepository {
  Future<bool> addNote(NotesCompanion note);
  Future<bool> editNote(NotesCompanion note);
  Future<bool> deleteNote(int noteId);
  Stream<List<Note>> getNotes();
}
