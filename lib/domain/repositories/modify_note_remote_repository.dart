import 'package:encrypted_notes/domain/models/notes.dart';

abstract class ModifyNoteRemoteRepository {
  Future<bool> addNote(Note note);
  Future<bool> editNote(Note note);
  Future<bool> deleteNote(int noteId);
  Stream<List<Note>> getNotes();
}
